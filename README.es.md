# Laboratorio de computación paralela con Docker Compose: cómo piensa una GPU, con NumPy y multiprocessing. No hay GPU

[English](README.md) | [Français](README.fr.md) | [Español](README.es.md) | [日本語](README.ja.md) | [Deutsch](README.de.md)

[![check](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml)

Un laboratorio listo para usar en clase, de la [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning), donde colegios, institutos, centros de formación y universidades dan a cada estudiante sus propias bases de datos, contenedores y terminal en el navegador. Es el modelo en el que se basa una GPU, con NumPy, multiprocessing de Python y unos pocos scripts pequeños, de modo que cada resultado es igual cada vez. En el laboratorio no hay ninguna GPU.

Es un único archivo `docker-compose`, `compose.yaml`, y funciona igual en tu propio ordenador que en la plataforma, donde cada estudiante tiene una copia privada sin salida a internet.

## Uso en la plataforma

La plataforma da a cada estudiante su propia copia de un laboratorio, en el navegador, con un terminal al lado.

**Para probarlo:** abre la [página de contenedores](https://mitsurutech.co.uk/container), busca este laboratorio en **Sample labs** y pulsa Start. Hace falta una cuenta gratuita.

**Para ponerlo como tarea a una clase:**

1. En tu módulo, crea una tarea de tipo **Lab** y elige **In a GitHub repository**.
2. Indica `https://github.com/mitsurutech/lab-parallel-lab` con la rama `main`. El archivo compose es el predeterminado, `compose.yaml`. Haz antes un fork del repositorio si quieres cambiarlo.
3. Publica. La copia de cada estudiante parte de la versión (commit) que publicaste, así que un cambio posterior aquí no altera un laboratorio ya asignado.

La [página de este laboratorio](https://mitsurutech.co.uk/help/lab-parallel-lab) del manual de ayuda y su [guía de laboratorios de contenedores](https://mitsurutech.co.uk/help/labs) explican el resto. La lección básica correspondiente es **Parallel Computing Basics**. ¿Aún no tienes cuenta de centro? [El primer año es gratis](https://mitsurutech.co.uk/pricing) hasta 50 estudiantes, y [registrarse](https://mitsurutech.co.uk/signup) solo pide una dirección de correo.

## Cómo ejecutarlo en tu propio ordenador

Necesitas Docker con el plugin Compose.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Abre <http://127.0.0.1:8888/lab>. `local.yaml` publica los puertos solo en `127.0.0.1`, así que el laboratorio es accesible desde tu propio ordenador y desde ningún otro sitio. Nada en él pide contraseña, así que no lo ejecutes donde otras personas puedan acceder. Páralo con `Ctrl-C` y elimínalo con `docker compose -f compose.yaml -f local.yaml down -v`.

## Qué no funciona en un laboratorio

El laboratorio no tiene salida a internet, así que no se puede instalar ni descargar nada en él. **Nada se guarda**: al detener el laboratorio se olvidan todos los archivos, de modo que el estudiante descarga su trabajo antes de pararlo. El comentario del principio de `compose.yaml` explica qué es el laboratorio y qué no es.

## Comprobar el laboratorio

`test/check.sh` arranca el laboratorio como lo hace el ejecutor de la plataforma con cada servicio (todas las capacidades retiradas, `no-new-privileges`, un límite de procesos, límites de memoria y sin salida a internet) y luego comprueba que el laboratorio hace lo que dice su archivo compose. Necesita Docker y se ejecuta en cada push, que es la insignia de arriba.

```bash
test/check.sh
```

## Licencia

Esta obra está bajo la licencia [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Puedes compartirla y adaptarla para aprender y enseñar, si reconoces la autoría de Mitsuru Technologies Ltd, no la usas con fines comerciales y compartes lo que crees a partir de ella bajo la misma licencia. El texto completo está en el archivo `LICENSE`.

## Acerca de

Creado por [Mitsuru Technologies](https://mitsurutech.co.uk) para la [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning): Python, Java, Go, Node, SQL y Linux en el navegador para colegios, institutos y centros de formación, con laboratorios de contenedores, aplicaciones web desplegadas desde GitHub y cuestionarios que se corrigen solos. Prueba código sin cuenta en el [playground](https://mitsurutech.co.uk/playground).

Más laboratorios del mismo sitio: [lab-computer-vision](https://github.com/mitsurutech/lab-computer-vision), [lab-frontend-web](https://github.com/mitsurutech/lab-frontend-web), [lab-usability](https://github.com/mitsurutech/lab-usability), [lab-mobile-web](https://github.com/mitsurutech/lab-mobile-web), [lab-quantum-sim](https://github.com/mitsurutech/lab-quantum-sim).
