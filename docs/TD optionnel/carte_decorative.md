# TD optionnel

## Objectif

L'objectif de ce TD optionnel est de créer une carte décorative centrée sur un lieu dans l'Hérault qui vous est cher.

### Etape 1

Sur Google Maps, repéré un lieu qui vous rappelle un bon souvenir. Faites alors un clic-droit sur la carte à l'endroit du lieu et cliquez sur les coordonnées afin de les copier.

Attention à l'ordre des coordonnées, Google Maps les donnent en latitude (Y), longitude (X).

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

* Téléchargez l'image disponible [à cette adresse](./images/etoile.png){:target="_blank"}.
* Ouvrez les propriétés de la couche `poi` et affichez les options de symbologie.
* Dans la fenêtre, sélectionnez le "Symbole simple".

![Symbole simple](./images/symbole_simple.png "Symbole simple")

* Dans "Type de symbole", sélectionnez "Symbole image raster".

![Symbole image raster](./images/symbole_image_raster.png "Symbole image raster")

* Appuyez sur le bouton "..." et sélectionnez le chemin vers l'image préalablement téléchargée.

![Sélection de l'étoile](./images/selection_etoile.png "Sélection de l'étoile")

* Modifiez la taille du symbole pour le passer à 8 millimètres.
* Dans "Rendu de la couche", cochez "Effets".
* Cliquez sur le bouton "* - Personnaliser les effets" et sélectionnez "Ombre portée".

![Effet d'ombre portée](./images/effet_ombre_portee.png "Effet d'ombre portée")

* Validez en cliquant sur "OK".

### Etape 8

* Ouvrez les propriétés de la couche `poi` et affichez les options d'étiquetage.
* Choisissez "Etiquettes simples", la valeur devrait automatiquement être remplie avec "coordonnees".
* Modifiez la police et la taille du texte.

![Texte de l'étiquette](./images/etiquette_texte.png "Texte de l'étiquette")

* Ajoutez un tampon blanc autour de l'étiquette.

![Tampon de l'étiquette](./images/etiquette_tampon.png "Tampon de l'étiquette")

* Positionnez l'étiquette en mode "Décalé par rapport au point" de sorte à ce qu'elle s'affiche 5 millimètres en dessous.

![Position de l'étiquette](./images/etiquette_position.png "Position de l'étiquette")

* Validez en cliquant sur "OK".

### Etape 9

* Ouvrez les propriétés de la couche `troncons_poi` et affichez les options de symbologie.
* Remplacez "Symbole unique" par "Catégorisé" et dans "Valeur" sélectionnez "importance".

![Symbologie Catégorisé](./images/symbologie_categorise.png "Symbologie Catégorisé")

* Cliquez 4 fois sur le "+ - Ajouter" et au niveau de la valeur des 3 premiers items, renseignez respectivement "1", "2" et "3".

![Catégories de symboles](./images/categories_symboles.png "Catégories de symboles")

* Double-cliquez sur le symbole du premier item pour en afficher les propriétés.
* Augmentez la taille à 0.8 millimètres et changez la couleur pour un gris foncé (code #707070), puis validez pour revenir aux options de symbologie.

![Symbole de la catégorie 1](./images/symbole_categorie_1.png "Symbole de la catégorie 1")

* Faites un clic-droit sur le symbole du premier item et copiez le symbole.

![Copier le symbole](./images/copier_symbole.png "Copier le symbole")

* Faites un clic-droit sur les autres items et collez le symbole.

![Coller le symbole](./images/coller_symbole.png "Coller le symbole")

* Double-cliquez sur le symbole du dernier item (celui sans valeur) pour en afficher les propriétés.
* Diminuez la taille du symbole à 0.2 millimètres.

* Validez en cliquant sur "OK".

### Etape 10

* Ouvrez les propriétés de la couche `batiments_notables_poi` et affichez les options de symbologie.
* Modifiez les propriétés du "Remplissage simple" pour que la couleur de remplissage soit noire et la couleur du trait blanche.

![Symbologie des bâtiments notables](./images/symbologie_batiments_notables.png "Symbologie des bâtiments notables")

* Validez en cliquant sur "OK".