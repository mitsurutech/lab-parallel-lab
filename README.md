# Parallel computing lab with Docker Compose: how a GPU thinks, with NumPy and multiprocessing. There is no GPU

[English](README.md) | [Français](README.fr.md) | [Español](README.es.md) | [日本語](README.ja.md) | [Deutsch](README.de.md)

[![check](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml)

A ready-made lab for classrooms, from the [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning), where schools, colleges and universities give every student their own databases, containers and terminal in the browser. It is the model a GPU is built on, with NumPy, Python multiprocessing and a few small scripts, so every result is the same each time. There is no GPU in the lab.

It is one `docker-compose` file, `compose.yaml`, and it runs the same on your own machine as it does on the platform, where every student gets a private copy with no way out to the internet.

## Using it on the platform

The platform gives every student their own copy of a lab, in the browser, with a terminal beside it.

**To try it:** open the [container page](https://mitsurutech.co.uk/container), find this lab in **Sample labs** and press Start. It needs a free account.

**To set it as work for a class:**

1. In your module, make a task of type **Lab** and choose **In a GitHub repository**.
2. Give `https://github.com/mitsurutech/lab-parallel-lab` with the branch `main`. The compose file is the default, `compose.yaml`. Fork the repository first if you want to change it.
3. Publish. Every student's copy starts from the commit you published, so a later change here does not alter a lab already set.

The help manual's [page for this lab](https://mitsurutech.co.uk/help/lab-parallel-lab) and its [guide to container labs](https://mitsurutech.co.uk/help/labs) cover the rest. The matching basic lesson is **Parallel Computing Basics**. No college account yet? [Your first year is free](https://mitsurutech.co.uk/pricing) for up to 50 students, and [signing up](https://mitsurutech.co.uk/signup) takes an email address.

## Running it on your own machine

You need Docker with the Compose plugin.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Open <http://127.0.0.1:8888/lab>. `local.yaml` publishes ports on `127.0.0.1` only, so the lab is reachable from your own computer and from nowhere else. Nothing in it asks for a password, so do not run it where other people can reach it. Stop it with `Ctrl-C`, and remove it with `docker compose -f compose.yaml -f local.yaml down -v`.

## What does not work in a lab

The lab has no way out to the internet, so nothing can be installed or downloaded into it. **Nothing is saved**: stopping the lab forgets every file, so a student downloads their work before they stop it. The comment at the top of `compose.yaml` says what the lab is and what it is not.

## Checking the lab

`test/check.sh` starts the lab the way the platform's runner starts every service (all capabilities dropped, `no-new-privileges`, a process limit, memory limits, and no way out to the internet) and then checks that the lab does what its compose file says. It needs Docker and runs on every push, which is the badge at the top.

```bash
test/check.sh
```

## Licence

This work is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). You may share it and adapt it for learning and teaching, if you credit Mitsuru Technologies Ltd, do not use it commercially, and share anything you make from it under the same licence. The full text is in the `LICENSE` file.

## About

Made by [Mitsuru Technologies](https://mitsurutech.co.uk) for the [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning): Python, Java, Go, Node, SQL and Linux in the browser for schools and colleges, with container labs, web apps deployed from GitHub, and quizzes that mark themselves. Try code with no account in the [playground](https://mitsurutech.co.uk/playground).

More labs from the same place: [lab-computer-vision](https://github.com/mitsurutech/lab-computer-vision), [lab-frontend-web](https://github.com/mitsurutech/lab-frontend-web), [lab-usability](https://github.com/mitsurutech/lab-usability), [lab-mobile-web](https://github.com/mitsurutech/lab-mobile-web), [lab-quantum-sim](https://github.com/mitsurutech/lab-quantum-sim).
