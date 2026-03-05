$ogr2ogr = "c:\Program Files\QGIS 3.44.6\bin\ogr2ogr.exe"
$psql = "c:\Program Files\PostgreSQL\15\bin\psql.exe"
$data_folder = $PSSCriptRoot

$pghost = "localhost"
$dbname = "tp_polytech"
$user = "postgres"

$password = Read-Host "Entrer le mot de passe"
$env:PGPASSWORD = $password

& "${psql}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    -c "drop schema if exists donnees_sources cascade" `
    -c "create schema if not exists donnees_sources"

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" "batiment" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -clipsrc 703914.6999999999534339 6283031.2000000001862645 724602.0999999999767169 6304109.2999999998137355

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" `
    -nln "batiment_notable" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -sql "select cleabs, nature, geometrie from batiment where nature in ('Arc de triomphe', 'Arène ou théâtre antique', 'Chapelle', 'Château', 'Eglise', 'Fort, blockhaus, casemate', 'Monument', 'Tour, donjon')"

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" "commune" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" "route_numerotee_ou_nommee" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" "surface_hydrographique" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -select "cleabs"

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" `
    -nln "troncon_de_route" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -sql "select cleabs, importance, geometrie from troncon_de_route where nature not in ('Bac ou liaison maritime', 'Chemin', 'Sentier')"

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\BDT_3-5_GPKG_LAMB93_D034-ED2025-12-15.gpkg" "troncon_de_voie_ferree" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom

& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\loc_mats_eolien.gpkg" "loc_mats_eolien" `
    -nln "mat_eolien" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -select "etat_,hauteur_ma" `
    -clipsrc 652958.4000000000232831 6217957.5999999996274710 811375.4000000000232831 6332632.9000000003725290

& "${psql}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    -c "alter table donnees_sources.mat_eolien rename column etat_ to etat" `
    -c "alter table donnees_sources.mat_eolien rename column hauteur_ma to hauteur"
    
& "${ogr2ogr}" `
    PG:"dbname='$dbname' host='$pghost' user='$user' password='$env:PGPASSWORD'" `
    -f PostgreSQL `
    "$data_folder\carreaux_1km_met.gpkg" "carreaux" `
    -nln "carroyage_insee" `
    -lco SCHEMA=donnees_sources `
    -lco OVERWRITE=YES `
    -lco GEOMETRY_NAME=geom `
    -clipsrc 652958.4000000000232831 6217957.5999999996274710 811375.4000000000232831 6332632.9000000003725290

& "${psql}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    -c "alter table donnees_sources.batiment drop column if exists fid" `
    -c "alter table donnees_sources.batiment_notable drop column if exists ogc_fid" `
    -c "alter table donnees_sources.commune drop column if exists fid" `
    -c "alter table donnees_sources.route_numerotee_ou_nommee drop column if exists fid" `
    -c "alter table donnees_sources.surface_hydrographique drop column if exists fid" `
    -c "alter table donnees_sources.troncon_de_route drop column if exists ogc_fid" `
    -c "alter table donnees_sources.troncon_de_voie_ferree drop column if exists fid" `
    -c "alter table donnees_sources.mat_eolien drop column if exists fid" `
    -c "alter table donnees_sources.carroyage_insee drop column if exists fid"