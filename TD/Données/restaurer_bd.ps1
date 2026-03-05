$psql = "c:\Program Files\PostgreSQL\15\bin\psql.exe"

$pghost = "localhost"
$dbname = "tp_polytech_restore"
$user = "postgres"

$password = Read-Host "Entrer le mot de passe"
$env:PGPASSWORD = $password

Expand-Archive `    -LiteralPath "$PSScriptRoot\..\..\docs\TD\initialisation_bdd.zip" `
    -DestinationPath "$PSScriptRoot\..\..\docs\TD\" `    -Force

& "${psql}" `
    -h $pghost `
    -U $user `
    -d $dbname `
    -f "$PSScriptRoot\..\..\docs\TD\initialisation_bdd.sql"