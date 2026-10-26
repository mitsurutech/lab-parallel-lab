# Laboratoire de calcul parallèle avec Docker Compose : comment pense un GPU, avec NumPy et multiprocessing. Il n'y a pas de GPU

[English](README.md) | [Français](README.fr.md) | [Español](README.es.md) | [日本語](README.ja.md) | [Deutsch](README.de.md)

[![check](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml)

Un laboratoire prêt à l'emploi pour la classe, proposé par la [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning), où écoles, lycées, établissements supérieurs et universités donnent à chaque étudiant ses propres bases de données, conteneurs et terminal dans le navigateur. C'est le modèle sur lequel un GPU est construit, avec NumPy, le module multiprocessing de Python et quelques petits scripts, de sorte que chaque résultat est identique à chaque exécution. Il n'y a pas de GPU dans le labo.

Il tient dans un seul fichier `docker-compose`, `compose.yaml`, et fonctionne de la même façon sur votre propre machine que sur la plateforme, où chaque étudiant dispose d'une copie privée sans aucun accès à internet.

## Utilisation sur la plateforme

La plateforme donne à chaque étudiant sa propre copie d'un labo, dans le navigateur, avec un terminal à côté.

**Pour l'essayer :** ouvrez la [page des conteneurs](https://mitsurutech.co.uk/container), trouvez ce labo dans **Sample labs** et appuyez sur Start. Un compte gratuit est nécessaire.

**Pour le donner comme travail à une classe :**

1. Dans votre module, créez une tâche de type **Lab** et choisissez **In a GitHub repository**.
2. Indiquez `https://github.com/mitsurutech/lab-parallel-lab` avec la branche `main`. Le fichier compose par défaut est `compose.yaml`. Faites d'abord un fork du dépôt si vous voulez le modifier.
3. Publiez. La copie de chaque étudiant part du commit que vous avez publié : une modification ultérieure ici ne change donc pas un labo déjà donné.

La [page de ce labo](https://mitsurutech.co.uk/help/lab-parallel-lab) du manuel d'aide et son [guide des labos de conteneurs](https://mitsurutech.co.uk/help/labs) disent le reste. La leçon de base associée s'intitule **Parallel Computing Basics**. Pas encore de compte d'établissement ? [La première année est gratuite](https://mitsurutech.co.uk/pricing) jusqu'à 50 étudiants, et [l'inscription](https://mitsurutech.co.uk/signup) ne demande qu'une adresse e-mail.

## Lancer le labo sur votre machine

Il vous faut Docker avec le plugin Compose.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Ouvrez <http://127.0.0.1:8888/lab>. `local.yaml` ne publie des ports que sur `127.0.0.1` : le labo n'est donc joignable que depuis votre propre ordinateur, et de nulle part ailleurs. Rien n'y demande de mot de passe, ne le lancez donc pas là où d'autres personnes peuvent y accéder. Arrêtez-le avec `Ctrl-C`, et supprimez-le avec `docker compose -f compose.yaml -f local.yaml down -v`.

## Ce qui ne fonctionne pas dans un labo

Le labo n'a aucun accès à internet : rien ne peut donc y être installé ni téléchargé. **Rien n'est enregistré** : arrêter le labo fait oublier tous les fichiers, l'étudiant télécharge donc son travail avant de l'arrêter. Le commentaire en tête de `compose.yaml` dit ce qu'est le labo et ce qu'il n'est pas.

## Vérification du labo

`test/check.sh` démarre le labo comme le lanceur de la plateforme démarre chaque service (toutes les capacités retirées, `no-new-privileges`, une limite de processus, des limites de mémoire, et aucun accès à internet), puis vérifie que le labo fait ce que dit son fichier compose. Il demande Docker et s'exécute à chaque push, ce que montre le badge en haut.

```bash
test/check.sh
```

## Licence

Cette œuvre est placée sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Vous pouvez la partager et l'adapter pour l'apprentissage et l'enseignement, à condition de citer Mitsuru Technologies Ltd, de ne pas l'utiliser à des fins commerciales et de partager ce que vous en tirez sous la même licence. Le texte complet se trouve dans le fichier `LICENSE`.

## À propos

Réalisé par [Mitsuru Technologies](https://mitsurutech.co.uk) pour la [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning) : Python, Java, Go, Node, SQL et Linux dans le navigateur pour les écoles et les établissements, avec des labos de conteneurs, des applications web déployées depuis GitHub et des quiz qui se corrigent eux-mêmes. Essayez du code sans compte dans le [playground](https://mitsurutech.co.uk/playground).

D'autres labos du même éditeur : [lab-computer-vision](https://github.com/mitsurutech/lab-computer-vision), [lab-frontend-web](https://github.com/mitsurutech/lab-frontend-web), [lab-usability](https://github.com/mitsurutech/lab-usability), [lab-mobile-web](https://github.com/mitsurutech/lab-mobile-web), [lab-quantum-sim](https://github.com/mitsurutech/lab-quantum-sim).
