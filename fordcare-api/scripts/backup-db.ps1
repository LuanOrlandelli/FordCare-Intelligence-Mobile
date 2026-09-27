# ==========================================================
# FordCare Intelligence
# PostgreSQL Backup Script
# ==========================================================

$ErrorActionPreference = "Stop"

$ContainerName = "fordcare-postgres"
$DatabaseName = "fordcare_db"
$DatabaseUser = if ($env:POSTGRES_USER) {
    $env:POSTGRES_USER
} else {
    "postgres"
}

$BackupDirectory = Join-Path $PSScriptRoot "..\backups"

if (-not (Test-Path $BackupDirectory)) {
    New-Item `
        -ItemType Directory `
        -Path $BackupDirectory | Out-Null
}

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$BackupFile = Join-Path `
    $BackupDirectory `
    "fordcare-$Timestamp.sql"

Write-Host "============================================"
Write-Host "FordCare Intelligence - Database Backup"
Write-Host "============================================"

$Running = docker inspect `
    -f "{{.State.Running}}" `
    $ContainerName 2>$null

if ($Running -ne "true") {
    throw "O container $ContainerName nao esta em execucao."
}

Write-Host "Gerando backup..."

docker exec `
    $ContainerName `
    pg_dump `
    -U $DatabaseUser `
    -d $DatabaseName `
    --clean `
    --if-exists `
    --no-owner `
    --no-privileges `
    > $BackupFile

if ($LASTEXITCODE -ne 0) {
    throw "Falha ao gerar backup."
}

if (-not (Test-Path $BackupFile)) {
    throw "O arquivo de backup nao foi criado."
}

if ((Get-Item $BackupFile).Length -eq 0) {
    Remove-Item $BackupFile -Force
    throw "O backup foi criado vazio."
}

Write-Host ""
Write-Host "Backup concluido com sucesso."
Write-Host "Arquivo: $BackupFile"