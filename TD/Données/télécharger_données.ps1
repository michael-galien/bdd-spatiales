$data_folder = $PSSCriptRoot

Invoke-WebRequest `    -Uri "https://data.geopf.fr/telechargement/download/BDTOPO/BDTOPO_3-5_TOUSTHEMES_GPKG_LAMB93_D034_2025-12-15/BDTOPO_3-5_TOUSTHEMES_GPKG_LAMB93_D034_2025-12-15.7z" `    -OutFile "$data_folder/BDTOPO_3-5_TOUSTHEMES_GPKG_LAMB93_D034_2025-12-15.7z"

Invoke-WebRequest `    -Uri "https://data.geopf.fr/telechargement/download/ENR/ENR_1-0_LOC-MAT-EOL_GPKG_LAMB93_FXX_2024-04-01/ENR_1-0_LOC-MAT-EOL_GPKG_LAMB93_FXX_2024-04-01.7z" `    -OutFile "$data_folder/ENR_1-0_LOC-MAT-EOL_GPKG_LAMB93_FXX_2024-04-01.7z"Invoke-WebRequest `    -Uri "https://www.insee.fr/fr/statistiques/fichier/8735171/Filosofi2021_carreaux_1km_gpkg.zip" `    -OutFile "$data_folder/Filosofi2021_carreaux_1km_gpkg.zip"