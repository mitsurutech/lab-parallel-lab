#!/usr/bin/env bash
# What the compose.yaml header promises, checked from inside the lab's own network and through
# docker exec, which is how the platform's terminal reaches the lab's Python: run by check.sh.
set -euo pipefail
: "${NET:?run through test/check.sh}"
: "${CID:?run through test/check.sh}"
probe() { docker run --rm --network "$NET" lab-check-probe bash -c "$1"; }
run() { docker exec "$CID" "$@"; }
fail() { echo "$1" >&2; exit 1; }

echo "- JupyterLab answers with no token to type"
probe '
set -eu
code=$(curl -s -o /dev/null -w "%{http_code}" http://jupyter:8888/lab)
[ "$code" = 200 ] || { echo "JupyterLab answered $code" >&2; exit 1; }
curl -fs http://jupyter:8888/api/contents | grep -q "start.ipynb" || { echo "no start.ipynb" >&2; exit 1; }
curl -fs -H "Host: someone-8888.example.com" -H "Origin: https://someone-8888.example.com" \
  http://jupyter:8888/api/kernelspecs | grep -q python3 || { echo "a proxied host is refused" >&2; exit 1; }
echo "- no way out to the internet"
if curl -s -m 4 -o /dev/null https://example.com; then echo "the lab reached the internet" >&2; exit 1; fi
'

echo "- the work folder holds the notebook and the six step scripts"
run ls start.ipynb steps/vectors.py steps/chunks.py steps/amdahl.py steps/kernel.py steps/transfer.py steps/coalesce.py >/dev/null

echo "- vectors.py: both results 333833500 and equal, 2000 loop operations against 1"
out=$(run python3 steps/vectors.py)
for want in "python loop result: 333833500" "one numpy operation result: 333833500" "the two results are equal: True" \
  "python-level operations in the loop: 2000" "python-level operations with numpy: 1"; do
  echo "$out" | grep -Fqx "$want" || fail "no '$want' in: $out"
done

echo "- chunks.py: multiprocessing.Pool works under the hardening, partial sums 55 155 255 355 total 820"
out=$(run python3 steps/chunks.py) || fail "chunks.py failed under the hardening: $out"
for want in "chunk 0 partial sum: 55" "chunk 1 partial sum: 155" "chunk 2 partial sum: 255" "chunk 3 partial sum: 355" \
  "total of the partial sums: 820" "sum done in one piece: 820"; do
  echo "$out" | grep -Fqx "$want" || fail "no '$want' in: $out"
done

echo "- amdahl.py: the table, and a limit of 10.0 at 10 percent serial"
out=$(run python3 steps/amdahl.py)
for want in "10 percent: [1.0, 1.82, 3.08, 4.71]" "25 percent: [1.0, 1.6, 2.29, 2.91]" "50 percent: [1.0, 1.33, 1.6, 1.78]" \
  "with 10 percent serial, even endless workers give at most 10.0"; do
  echo "$out" | grep -Fqx "$want" || fail "no '$want' in: $out"
done

echo "- kernel.py: 12 threads in 3 blocks of 4, two past the end, c is a plus b"
out=$(run python3 steps/kernel.py)
echo "$out" | grep -Fqx "launch: 3 blocks of 4 threads" || fail "no launch line: $out"
[ "$(echo "$out" | grep -c ' adds a\[')" = 10 ] || fail "not 10 threads adding: $out"
[ "$(echo "$out" | grep -c 'is past the end, does nothing')" = 2 ] || fail "not 2 threads past the end: $out"
echo "$out" | grep -Fqx "result: [11, 22, 33, 44, 55, 66, 77, 88, 99, 110]" || fail "wrong result: $out"

echo "- transfer.py: vector add limited by memory, matrix multiply by compute"
out=$(run python3 steps/transfer.py)
for want in "  bytes moved: 120000000" "  time to move the bytes, microseconds: 240.0" "  time to do the sums, microseconds: 1.0" \
  "  limited by: memory" "  bytes moved: 12000000" "  sums done: 2000000000" "  time to do the sums, microseconds: 200.0" \
  "  limited by: compute"; do
  echo "$out" | grep -Fqx "$want" || fail "no '$want' in: $out"
done

echo "- coalesce.py: stride 1 fetches 1 line, stride 8 fetches 8"
out=$(run python3 steps/coalesce.py)
echo "$out" | grep -Fqx "  32-byte lines fetched: 1 [0]" || fail "stride 1: $out"
echo "$out" | grep -Fqx "  32-byte lines fetched: 8 [0, 1, 2, 3, 4, 5, 6, 7]" || fail "stride 8: $out"

echo "- the starter notebook runs from top to bottom inside the memory limit"
run jupyter nbconvert --to notebook --execute start.ipynb --output /tmp/ran.ipynb >/dev/null 2>&1 \
  || fail "start.ipynb does not run"
echo "  ok"
