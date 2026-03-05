# TD optionnel

## Objectif

L'objectif de ce TD optionnel est de créer une carte décorative centrée sur un lieu dans l'Hérault qui vous est cher.

### Etape 1

Sur Google Maps, repéré un lieu qui vous rappelle un bon souvenir. Faites alors un clic-droit sur la carte à l'endroit du lieu et cliquer sur les coordonnées afin de les copier.

Attention à l'ordre des coordonnées, Google Maps les donnent en latitude (X), longitude (Y).

![Identification du lieu sur Google Maps](./images/lieu_google_maps.png "Identification du lieu sur Google Maps")

### Etape 2

Créez une table `poi(coordonnees, geom)` avec :
- `coordonnees` : les coordonnées WGS84 du point d'intérêt exprimées en degrés, minutes, secondes,
- `geom` : la localisation du point d'intérêt en Lambert-93.

### Etape 3

Créez une table `troncons_poi(cleabs, importance, geom)` contenant tous les `troncon_de_route` à une distance maximale de 2500 mètres du point d'intérêt.

### Etape 4

Créez une table `batiments_notables_poi(cleabs, importance, geom)` contenant tous les `batiment_notable` à une distance maximale de 2500 mètres du point d'intérêt.

### Etape 5

Créez une table `surfaces_hydrographiques_poi(geom)` qui contient l'intersection des `surface_hydrographique` avec une zone tampon de 2500 mètres autour du point d'intérêt.

### Etape 6

Dans une nouveau projet QGIS, ajoutez les couches de haut en bas dans l'ordre suivant :

* `poi`
* `troncons_poi`
* `batiments_notables_poi`
* `surfaces_hydrographiques_poi`

Le panneau "Couches" devrait alors afficher quelque chose de semblable à ceci :

![Panneau Couches](./images/panneau_couches.png "Panneau Couches")

### Etape 7

* Télécharger l'image disponible [à cette adresse](./images/etoile.png){:target="_blank"}.
* Ouvrez les propriétés de la couche `poi` et affichez les options de symbologie.
* Dans la fenêtre, sélectionnez le "Symbole simple".

![Symbole simple](./images/symbole_simple.png "Symbole simple")

* Dans "Type de symbole", sélectionnez "Symbole image raster"

![Symbole image raster](./images/symbole_image_raster.png "Symbole image raster")