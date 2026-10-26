#!/usr/bin/env bash
# Starts the lab the way the platform runs it and checks it does what the README says.
#   test/check.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
project="${PROJECT:-lab-check}"
override="$root/test/hardened.generated.yaml"

# Every service gets the hardening, and memory-swap equal to its memory limit.
services=$(docker compose -f "$root/compose.yaml" config --services)
{
  cat "$root/test/hardened.yaml"
  echo "services:"
  for s in $services; do
    mem=$(docker compose -f "$root/compose.yaml" config --format json \
      | python3 -c "import json,sys; d=json.load(sys.stdin)['services']['$s']; print(((d.get('deploy') or {}).get('resources') or {}).get('limits',{}).get('memory') or 536870912)")
    printf '  %s:\n    <<: *hardened\n    hostname: %s\n    memswap_limit: %s\n' "$s" "$s" "$mem"
  done
} > "$override"

compose() { docker compose -p "$project" -f "$root/compose.yaml" -f "$override" "$@"; }
cleanup() { docker compose -p "$project" down -v --remove-orphans >/dev/null 2>&1 || true; rm -f "$override"; }
trap cleanup EXIT
docker compose -p "$project" down -v --remove-orphans >/dev/null 2>&1 || true

# local.yaml, the file the README tells you to run on your own machine, is valid beside it.
docker compose -f "$root/compose.yaml" -f "$root/local.yaml" config --quiet

docker build -q -t lab-check-probe -f "$root/test/Dockerfile.probe" "$root/test" >/dev/null
compose up -d --wait --wait-timeout 600

# The hardening really took: a check that ran without it proves nothing.
for c in $(compose ps -q); do
  docker inspect "$c" --format '{{.Name}} {{.HostConfig.CapDrop}} {{.HostConfig.SecurityOpt}} {{.HostConfig.PidsLimit}} {{.HostConfig.Memory}}={{.HostConfig.MemorySwap}}' \
    | tee /dev/stderr | grep -q '\[ALL\] \[no-new-privileges\] 256 \([0-9]*\)=\1$' || { echo "not hardened" >&2; exit 1; }
done
NET="${project}_lab" CID="$(compose ps -q jupyter)" bash "$root/test/lab.sh"
echo "ok"
