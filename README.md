# makefiles
[![pipeline status](https://git.sk5.io/skale-5/makefiles/badges/main/pipeline.svg?ignore_skipped=true)](https://git.sk5.io/skale-5/makefiles/-/commits/main)
[![Latest Release](https://git.sk5.io/skale-5/makefiles/-/badges/release.svg)](https://git.sk5.io/skale-5/makefiles/-/releases)

Ce repo vise à centraliser la gestion des Makefiles utilisés à Skale-5. En effet, les Makefiles sont aujourd'hui peu mis à jour chez les clients.
Ce repo est intégré comme un submodule git dans les repos d'infrastructure client.

Il est également utilisé pour les repos internes Skale 5 qui nécessitent un Makefile (par exemple les cookiecutters)

## Installer le Makefile dans un repo client existant (fichier .gitmodules absent)

Ajouter le submodule :

```bash
git submodule add git@git.sk5.io:skale-5/makefiles.git
```

Si on veut donner l'accès public à la place :

```bash
git submodule add https://github.com/skale-5/makefiles.git
```

Créer un lien avec le Makefile voulu :

```bash
ln -s makefiles/Makefile.XXXXX.mk Makefile
```



## Initialiser les submodules chez un client déjà configuré (fichier .gitmodules présent)

```bash
git submodule update --init --recursive
```

## Mettre à jour les submodules vers la dernière version
```bash
git submodule foreach git pull origin main
```

## Surcharger le Makefile sans faire de modifications sur le repo

Les `.mk` contenus dans les dossiers `custom/` sont automatiquement inclus. Il est donc possible d'y ajouter de la conf spécifique (variable, nouvelles macros, ...)
