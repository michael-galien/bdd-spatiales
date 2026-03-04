$psql = "c:\Program Files\PostgreSQL\15\bin\psql.exe"
$pgdump = "c:\Program Files\PostgreSQL\15\bin\pg_dump.exe"

$pghost = "localhost"
$dbname = "tp_polytech"
$user = "postgres"

$password = Read-Host "Entrer le mot de passe"
$env:PGPASSWORD = $password

& "${psql}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    -c "drop schema if exists donnees_resultats cascade" `
    -c "create schema donnees_resultats" `
    -c "create table donnees_resultats.points_incendie_4326 as select * from public.points_incendie_4326" `
    -c "create table donnees_resultats.points_incendie_2154 as select * from public.points_incendie_2154" `
    -c "create table donnees_resultats.ligne_incendie as select * from public.ligne_incendie" `
    -c "create table donnees_resultats.contour_incendie as select * from public.contour_incendie" `
    -c "create table donnees_resultats.zone_incendie as select * from public.zone_incendie" `
    -c "create table donnees_resultats.nb_ha_incendie as select * from public.nb_ha_incendie" `
    -c "create table donnees_resultats.commune_incendie as select * from public.commune_incendie" `
    -c "create table donnees_resultats.communes_limitrophes_incendie as select * from public.communes_limitrophes_incendie" `
    -c "create table donnees_resultats.perimetre_securite as select * from public.perimetre_securite" `
    -c "create table donnees_resultats.coupures_routes as select * from public.coupures_routes" `
    -c "create table donnees_resultats.perimetres_communaux_securite as select * from public.perimetres_communaux_securite" `
    -c "create table donnees_resultats.parts_perimetres_communaux_securite as select * from public.parts_perimetres_communaux_securite" `
    -c "create table donnees_resultats.mats_eoliens_proximite as select * from public.mats_eoliens_proximite" `
    -c "create table donnees_resultats.pp_voie_ferree as select * from public.pp_voie_ferree" `
    -c "create table donnees_resultats.point_pp_voie_ferree as select * from public.point_pp_voie_ferree" `
    -c "create table donnees_resultats.batiments_perimetre_securite as select * from public.batiments_perimetre_securite" `
    -c "create table donnees_resultats.clusters_residentiels_perimetre_securite as select * from public.clusters_residentiels_perimetre_securite" `
    -c "create table donnees_resultats.enveloppes_clusters_perimetre_securite as select * from public.enveloppes_clusters_perimetre_securite" `
    -c "create table donnees_resultats.distances_enveloppes_perimetre_securite as select * from public.distances_enveloppes_perimetre_securite" `
    -c "create table donnees_resultats.front_feu as select * from public.front_feu" `
    -c "create table donnees_resultats.fumees as select * from public.fumees" `
    -c "create table donnees_resultats.personnes_vulnerables as select * from public.personnes_vulnerables" `
    -c "create table donnees_resultats.zone_incendie_fixe as select * from public.zone_incendie_fixe" `
    -c "create table donnees_resultats.distance_parcourue_incendie as select * from public.distance_parcourue_incendie" `
    -c "create table donnees_resultats.grille_incendie_fixe as select * from public.grille_incendie_fixe"

& "${pgdump}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    --no-owner `
    --schema donnees_sources `
    --schema donnees_resultats `
    --clean `
    --if-exists `
    -f "$PSScriptRoot\..\..\docs\TD\initialisation_bdd.sql"

Compress-Archive `    -LiteralPath "$PSScriptRoot\..\..\docs\TD\initialisation_bdd.sql" `
    -DestinationPath "$PSScriptRoot\..\..\docs\TD\initialisation_bdd.zip" `    -Force