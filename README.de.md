# Paralleles-Rechnen-Lab mit Docker Compose: wie eine GPU denkt, mit NumPy und multiprocessing. Es gibt keine GPU

[English](README.md) | [Français](README.fr.md) | [Español](README.es.md) | [日本語](README.ja.md) | [Deutsch](README.de.md)

[![check](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml)

Ein fertiges Lab für den Unterricht von der [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning), auf der Schulen, Colleges und Hochschulen jedem Lernenden eigene Datenbanken, Container und ein Terminal im Browser bereitstellen. Es zeigt das Modell, auf dem eine GPU beruht, mit NumPy, Python-multiprocessing und ein paar kleinen Skripten, sodass jedes Ergebnis bei jedem Lauf gleich ist. Im Lab gibt es keine GPU.

Es besteht aus einer einzigen `docker-compose`-Datei, `compose.yaml`, und läuft auf Ihrem eigenen Rechner genauso wie auf der Plattform, wo jede lernende Person eine private Kopie ohne Zugang zum Internet erhält.

## Auf der Plattform nutzen

Die Plattform gibt jeder lernenden Person eine eigene Kopie eines Labs, im Browser, mit einem Terminal daneben.

**Zum Ausprobieren:** Öffnen Sie die [Container-Seite](https://mitsurutech.co.uk/container), suchen Sie dieses Lab unter **Sample labs** und klicken Sie auf Start. Dafür ist ein kostenloses Konto nötig.

**Als Aufgabe für eine Klasse stellen:**

1. Legen Sie in Ihrem Modul eine Aufgabe vom Typ **Lab** an und wählen Sie **In a GitHub repository**.
2. Geben Sie `https://github.com/mitsurutech/lab-parallel-lab` mit dem Branch `main` an. Die Compose-Datei ist die Standarddatei, `compose.yaml`. Forken Sie das Repository zuerst, wenn Sie etwas ändern möchten.
3. Veröffentlichen Sie die Aufgabe. Die Kopie jeder lernenden Person beginnt mit dem Commit, den Sie veröffentlicht haben, eine spätere Änderung hier verändert also kein bereits gestelltes Lab.

Die [Seite zu diesem Lab](https://mitsurutech.co.uk/help/lab-parallel-lab) im Hilfehandbuch und die [Anleitung zu Container-Labs](https://mitsurutech.co.uk/help/labs) beantworten die übrigen Fragen. Die passende Grundlagenlektion heißt **Parallel Computing Basics**. Noch kein Konto für Ihre Einrichtung? [Das erste Jahr ist kostenlos](https://mitsurutech.co.uk/pricing) für bis zu 50 Lernende, und die [Registrierung](https://mitsurutech.co.uk/signup) braucht nur eine E-Mail-Adresse.

## Auf dem eigenen Rechner ausführen

Sie brauchen Docker mit dem Compose-Plugin.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Öffnen Sie <http://127.0.0.1:8888/lab>. `local.yaml` veröffentlicht Ports nur auf `127.0.0.1`, das Lab ist also von Ihrem eigenen Rechner aus erreichbar und von sonst nirgends. Nichts darin fragt nach einem Passwort, betreiben Sie es daher nicht dort, wo andere es erreichen können. Beenden Sie es mit `Strg-C` und entfernen Sie es mit `docker compose -f compose.yaml -f local.yaml down -v`.

## Was in einem Lab nicht funktioniert

Das Lab hat keinen Zugang zum Internet, es lässt sich also nichts hineininstallieren oder herunterladen. **Nichts wird gespeichert**: Beim Beenden des Labs gehen alle Dateien verloren, Lernende laden ihre Arbeit also herunter, bevor sie das Lab beenden. Der Kommentar am Anfang von `compose.yaml` beschreibt, was das Lab ist und was nicht.

## Das Lab prüfen

`test/check.sh` startet das Lab so, wie der Runner der Plattform jeden Dienst startet (alle Capabilities entzogen, `no-new-privileges`, ein Prozesslimit, Speicherlimits und kein Zugang zum Internet), und prüft dann, ob das Lab das tut, was seine Compose-Datei sagt. Es braucht Docker und läuft bei jedem Push, das ist das Badge oben.

```bash
test/check.sh
```

## Lizenz

Dieses Werk steht unter der Lizenz [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Sie dürfen es für Lernen und Lehren weitergeben und bearbeiten, wenn Sie Mitsuru Technologies Ltd nennen, es nicht kommerziell nutzen und alles, was Sie daraus machen, unter derselben Lizenz weitergeben. Der vollständige Text steht in der Datei `LICENSE`.

## Über uns

Entwickelt von [Mitsuru Technologies](https://mitsurutech.co.uk) für die [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning): Python, Java, Go, Node, SQL und Linux im Browser für Schulen und Colleges, mit Container-Labs, aus GitHub bereitgestellten Web-Apps und Quizzen, die sich selbst auswerten. Code ohne Konto ausprobieren können Sie im [Playground](https://mitsurutech.co.uk/playground).

Weitere Labs vom selben Ort: [lab-computer-vision](https://github.com/mitsurutech/lab-computer-vision), [lab-frontend-web](https://github.com/mitsurutech/lab-frontend-web), [lab-usability](https://github.com/mitsurutech/lab-usability), [lab-mobile-web](https://github.com/mitsurutech/lab-mobile-web), [lab-quantum-sim](https://github.com/mitsurutech/lab-quantum-sim).
