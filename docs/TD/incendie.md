# Scénario

Un incendie est en cours au Nord du département de l'Hérault.
Le Commandant des Opérations de Secours (COS) a besoin d'informations sur la zone pour déployer de façon optimale les moyens sur place.

# Instructions et étapes préalables

4326 / 2154 (en mètres)
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

Les questions 1 à 5 vont permettre de créer le polygone du contour du feu.

Créez une table contenant les points fournis par la cellule drone, pour cela :
* Créez une table `points_incendie_4326` avec une colonne `id` de type `serial` (auto-incrément).
* Ajoutez à la table une colonne `geom` de type point à 2 dimensions et utilisant le système de coordonnées WGS84 ([EPSG:4326](https://epsg.io/4326)).
* Ajoutez à la table les 4 points suivants en respectant l'ordre d'insertion :
    * latitude (X) : 3.173279, longitude (Y) : 43.802700
    * latitude (X) : 3.151442, longitude (Y) : 43.808838
    * latitude (X) : 3.147681, longitude (Y) : 43.804279
    * latitude (X) : 3.150504, longitude (Y) : 43.798245
    
## Question 2

Créez une table `points_incendie_2154` ayant la même structure et le même contenu que la table `points_incendie_4326` mais avec la géométrie reprojetée en Lambert-93 ([EPSG:2154](https://epsg.io/2154)).

## Question 3

Créez une table `ligne_incendie` contenant dans une colonne `geom` la ligne construite à l'appui des points ordonnée par l'`id` de la table `points_incendie_2154`.

## Question 4

Pour pouvoir créer le contour de feu, il faut disposer d'une ligne fermée c'est à dire d'une ligne dont le premier point est égal au dernier point.

Créez une table `contour_incendie` contenant une colonne `geom` remplie avec la ligne de la table `ligne_incendie` à laquelle vous aurez ajouté un point égal au point de départ de la ligne.

## Question 5

Créez une table `zone_incendie` contenant une colonne `geom` remplie avec le polygone construit à l'appui de la ligne de la table `contour_incendie`.

## Question 6

Le COS vous demande quelle surface a déjà parcourue l'incendie.

Créez une table `nb_ha_incendie` contenant toutes les colonnes de la table  `zone_incendie` plus la surface de la zone exprimée en hectares.

## Question 7

## Question 8

## Question 9

## Question 10

## Question 11

## Question 12

## Question 13

## Question 14

## Question 15

## Question 16

## Question 17

## Question 18

## Question 19

## Question 20

## Question 21

## Question 22

## Question 23

## Question 24

## Question 25