# makefiles

Ce repo vise à centraliser la gestion des Makefiles utilisés à Skale-5. En effet, les `Makefiles` sont aujourd'hui peu mis à jour chez les clients.
Ce repo est intégré comme un submodule git dans les repos d'infrastrcture client.

Il est également utilisé pour les repos internes Skale 5 qui nécessitent un Makefile (par exemple les cookiecutters)

## Installer le Makefile dans un repo client existant

## Surcharger le Makefile sans faire de modifications sur le repo

Les `.mk` contenus dans les dossiers `custom/` sont automatiquement inclus. Il est donc possible d'y ajouter de la conf spécifique (variable, nouvelles macros, ...)
