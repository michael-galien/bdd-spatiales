# Scénario

Un incendie est en cours au Nord du département de l'Hérault.
Le Commandant des Opérations de Secours (COS) a besoin d'informations sur la zone pour déployer de façon optimale les moyens sur place.

# Instructions et étapes préalables

4326 / 2154
Initialisation de la BDD
Paramètrage de QGIs (tile Google Maps + connexion PG)
drop if exists / create
correction dispo dans le schéma

# Questions

## Question 1

La [Cellule de Reconnaissance et d’Investigation Drone](https://www.sdis34.fr/la-cellule-de-reconnaissance-et-dinvestigation-drone/) vient de survoler la zone.

Elle indique que le point d'éclosion se situe à 43°48'9.720"N 3°10'23.804"E.
Le front de feu est quant à lui positionné sur une ligne définie par les 3 points suivants :
* 43°48'31.817"N 3°9'5.191"E
* 43°48'15.404"N 3°8'51.652"E
* 43°47'53.682"N 3°9'1.814"E

Créer une table contenant les points fournis par la cellule drone, pour cela :
* Créer une table `points_incendie_4326` avec une colonne `id` de type `serial` (auto-incrément).
* Ajouter à la table une colonne `geom` de type point à 2 dimensions et utilisant le système de coordonnées WGS84 ([EPSG:4326](https://epsg.io/4326)).
* Ajouter à la table les 4 points suivants en respectant l'ordre :
    * latitude (X) : 3.173279, longitude (Y) : 43.802700
    * latitude (X) : 3.151442, longitude (Y) : 43.808838
    * latitude (X) : 3.147681, longitude (Y) : 43.804279
    * latitude (X) : 3.150504, longitude (Y) : 43.798245
    
## Question 2

Créer une table `points_incendie_2154` contenant l'`id` ainsi qu'une colonne `geom` remplie avec la géométrie de la table `points_incendie_4326` reprojetée en Lambert-93 ([EPSG:2154](https://epsg.io/2154)).

## Question 3