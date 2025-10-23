# Sujet

Une [centrale solaire photovoltaïque](https://fr.wikipedia.org/wiki/Centrale_solaire_photovolta%C3%AFque) dispose d'un appareil appelé [datalogger](https://en.wikipedia.org/wiki/Data_logger) qui nous transmet chaque jour des données de production d'énergie.

Cette installation est composée de 2 [onduleurs](https://fr.wikipedia.org/wiki/Onduleur).

Vous devrez construire une application permettant à un·e utilisateur·ice de :

- charger des données de production au format csv depuis une interface web
- disposer de ces données brutes ainsi que des données consolidées dans la base de données
- les consulter depuis une interface web

# Spécifications techniques

Il vous faudra réaliser une interface web simple (pas de mise en forme CSS demandée) qui permet de :
- envoyer un fichier CSV à charger au format CSV uniquement. Elles contiennent la production horaire de chaque onduleur. *(cf fichiers .csv dans ce repository)*
- voir la production totale d'une journée (au choix de l'utilisateur·ice) pour l'ensemble du système avec le total et la production par heure

Dans la base de données on devra pouvoir disposer :
- des données horaires de chaque onduleur
- des données consolidées (somme des énergies) sur la journée pour l'ensemble du système

Pour ce faire, nous mettons à votre disposition un starter d'application `RubyOnRails` + `SQLite` mais, il vous est possible d'utiliser une ou des technologie(s) équivalente(s) si vous n'êtes vraiment pas à l'aise avec `RubyOnRails` (ex: `Django`, `Symfony`, `Laravel`, etc.).

# Nous observerons

- Les modèles créés et leurs relations
- L'algorithme d'import
- La qualité et l'organisation du code en général

Évidemment, nous adapterons nos observations à votre expérience du langage.


# Setup

Il est possible de lancer l'application en mode _development_ de deux manières :

1. directement avec un environement ruby préalablement installé

  a) utilisation d'un gestionnaire de version : rbenv, rvm, asdf, etc...

  b) une installation de ruby et positionnement de la variable BUNDLE_PATH pour le stockage des gems

  ... et installer les gems : `bundle install` 

  ... puis `bin/rails server`

2. avec docker

  ( voir les fichiers Dockerfile et compose.yml )

`docker compose up -d`


**Merci de mettre le code à disposition sur un dépôt git et de nous transmettre les moyens d'y accéder.**


