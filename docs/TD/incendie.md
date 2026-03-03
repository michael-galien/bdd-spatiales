# TD

## Scénario

Un incendie est en cours au Nord du département de l'Hérault.

Des vents forts d'Est en Ouest font que celui-ci progresse rapidement et qu'un important panache de fumée se dégage en direction de zones habitées.

Le Commandant des Opérations de Secours (COS) a besoin d'informations sur la zone pour déployer de façon optimale les moyens sur place.
Il vous demande de lui fournir plusieurs éléments à l'appui des données géographiques dont vous disposez.

## Instructions

Pour répondre aux questions du COS, vous allez devoir créer plusieurs tables PostgreSQL contenant une colonne géographique PostGIS.
Dans chacune des tables, la colonne géographique devra être nommée `geom`.

Pour pouvoir rejouer facilement l'intégralité du script SQL que vous allez rédiger durant le TD, chaque création de table devra être précédée d'un ordre SQL de suppression de la forme `drop table if exists <nom_table>;`.

Sauf précision, le système de coordonnées utilisé sera le Lambert-93 ([SRID 2154](https://epsg.io/2154)).
Dans cette projection, les mesures sont exprimées en m et m².

L'autre système utilisé sera le WGS84 ([SRID 4326](https://epsg.io/4326)).
Les questions qui devront utiliser ce système l'indiqueront explicitement.

A noter que la réponse à certaines questions se base sur le résultat des précédentes.
Aussi, si vous bloquez sur une question, vous pouvez trouver le résultat dans le schéma `donnees_resultats`.

Vous l'aurez compris, ce qui sera jugé ce ne sont pas les résultats en tant que tels mais bien les requêtes qui ont permis de les obtenir.
Pensez donc à sauvegarder vos requêtes dans un fichier .sql et, à l'issue des 6h de TD, merci de me transférer ce fichier par e-mail.

N'hésitez pas à vous référer [au cours](../Cours/Cours.pdf) ainsi qu'à la [documentation de PostGIS](https://postgis.net/docs/reference.html).

## Etapes préalables

### Initialisation de la BDD

### Paramètrage de QGIS

#### Tile Google Maps

#### Connexion PostgreSQL

## Questions

### Question 1

La [Cellule de Reconnaissance et d’Investigation Drone](https://www.sdis34.fr/la-cellule-de-reconnaissance-et-dinvestigation-drone/) vient de survoler la zone.

Elle indique que le point d'éclosion se situe à 43°48'9.720"N 3°10'23.804"E.
Le front de feu est quant à lui positionné sur une ligne définie par les 3 points suivants :
* 43°48'31.817"N 3°9'5.191"E
* 43°48'15.404"N 3°8'51.652"E
* 43°47'53.682"N 3°9'1.814"E

Les questions 1 à 5 vont permettre de créer le polygone de contour du feu.

Créez une table contenant les points fournis par la cellule drone, pour cela :
* Créez une table `points_incendie_4326` avec une colonne `id` de type `serial` (auto-incrément).
* Ajoutez à la table une colonne `geom` de type point à 2 dimensions et utilisant le système de coordonnées WGS84.
* Ajoutez à la table les 4 points suivants en respectant l'ordre d'insertion :
    * latitude (X) : 3.173279, longitude (Y) : 43.802700
    * latitude (X) : 3.151442, longitude (Y) : 43.808838
    * latitude (X) : 3.147681, longitude (Y) : 43.804279
    * latitude (X) : 3.150504, longitude (Y) : 43.798245
    
### Question 2

Créez une table `points_incendie_2154` ayant la même structure et le même contenu que la table `points_incendie_4326` mais avec la géométrie reprojetée en Lambert-93.

### Question 3

Créez une table `ligne_incendie` contenant la ligne construite à l'appui des points de la table `points_incendie_2154` ordonnés par l'`id`.

### Question 4

Pour pouvoir créer le contour de feu, il faut disposer d'une ligne fermée c'est-à-dire d'une ligne dont le premier point est égal au dernier point.

Créez une table `contour_incendie` alimentée avec la ligne de la table `ligne_incendie` à laquelle vous aurez ajouté un point égal à son point de départ.

### Question 5

Créez une table `zone_incendie` contenant le polygone construit à l'appui de la ligne de la table `contour_incendie`.

### Question 6

Le COS souhaite connaître la surface déjà parcourue par l'incendie.

Créez une table `nb_ha_incendie` contenant toutes les colonnes de la table `zone_incendie` plus la surface de la zone exprimée en hectares.

### Question 7

La zone très boisée rend difficile l'identification des limites communales.
Le COS vous demande de lui confirmer que seule la commune de Joncels est pour l'heure impactée par l'incendie.

Créez une table `commune_incendie` confirmant la commune d'emprise de l'incendie.
Cette table doit avoir les mêmes champs que la table `commune`.

### Question 8

Le COS souhaite informer les maires des communes limitrophes des opérations en cours et vous demande la liste des communes concernées.

Créez une table `communes_limitrophes_incendie` qui liste les communes limitrophes à celle de la table `commune_incendie`.
Cette table doit avoir les mêmes champs que la table `commune`.

### Question 9

Le COS souhaite mettre en place un périmètre de sécurité de 1500 mètres autour de la zone d'incendie.

Créez une table `perimetre_securite` qui contient un polygone de la zone d'incendie étendue de 1500 mètres.

### Question 10

Des forces de l'ordre vont être déployées pour couper les routes au niveau du périmètre de sécurité.

A l'aide de la table `route_numerotee_ou_nommee`, créez une table `coupures_routes` qui liste les points, avec le numéro de route correspondant, où doivent être positionnées les forces de l'ordre.

La requête doit débuter par une CTE qui donne l'anneau extérieur du périmètre de sécurité présent dans la table `perimetre_securite`.

### Question 11

Le COS a besoin de connaître la surface, en nombre d'hectares, du périmètre de sécurité pour chaque commune concernée.

Créez une table `perimetres_communaux_securite` contenant les polygones des périmètres de sécurité sur l'emprise de chacune des communes concernées.
En plus de la géométrie, cette table doit donner la surface de chaque polygone en hectares.

Il est recommandé d'utiliser une CTE.

### Question 12

En repartant de la table `perimetres_communaux_securite` et en utilisant les fonctions de fenêtrage, créez une table `parts_perimetres_communaux_securite` qui donne :

* le pourcentage que représente le périmètre de sécurité de la commune sur le périmètre total de sécurité (100 * nb hectares périmètre communal / nb hectares périmètre total),
* le pourcentage que représente le périmètre de sécurité de la commune sur le périmètre de sécurité du département (100 * nb hectares périmètre communal / nb hectares périmètre départemental).

### Question 13

Plusieurs mats éoliens se trouvent à proximité de la zone d'incendie.
Ceux-ci représentent un réel danger pour les pilotes de Canadair lors des largages, d'autant que les fumées les rendent peu visibles.

Les pilotes vous demandent de leur fournir la liste des mats éoliens en service à 5km à la ronde du feu.
Pour chaque mât, ils souhaitent avoir :
* la longitude, c'est à dire la coordonnée X en WGS84,
* la latitude, c'est à dire la coordonnée Y en WGS84,
* la hauteur du mât.

Créez une table `mats_eoliens_proximite` avec les renseignements attendus par les pilotes ainsi qu'une colonne `geom` contenant la localisation ponctuelle des mâts en WGS84.

### Question 14

Le point d'éclosion de l'incendie se trouve à proximité d'un chemin de fer.
Le passage d'un train pourrait être à l'origine du départ de feu.

Pour mener des investigations, le COS vous demande d'identifier le tronçon de voie ferrée le plus proche de l'incendie.

Créez une table `pp_voie_ferree` contenant le tronçon de voie ferrée le plus proche de la zone d'incendie.
Pour cela, vous pouvez ordonner de façon croissante les troçons de voie ferrée suivant leur distance à la zone d'incendie et [ne garder que le premier résultat](https://www.postgresql.org/docs/current/queries-limit.html).

### Question 15

Créez une table `point_pp_voie_ferree` qui donne le point le plus proche de la zone d'incendie sur le tronçon présent dans la table `pp_voie_ferree`.

### Question 16

### Question 17

### Question 18

### Question 19

### Question 20

### Question 21

### Question 22

### Question 23

### Question 24

### Question 25