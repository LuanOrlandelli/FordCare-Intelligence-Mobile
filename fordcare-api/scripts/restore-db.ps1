# ==========================================================
# FordCare Intelligence
# PostgreSQL Restore Script
# ==========================================================

param (
    [Parameter(Mandatory = $true)]
    [string]$BackupFile
)

$ErrorActionPreference = "Stop"

$ContainerName = "fordcare-postgres"
$DatabaseName = "fordcare_db"

$DatabaseUser = if ($env:POSTGRES_USER) {
    $env:POSTGRES_USER
} else {
    "postgres"
}

if (-not (Test-Path $BackupFile)) {
    throw "Arquivo de backup nao encontrado: $BackupFile"
}

$Running = docker inspect `
    -f "{{.State.Running}}" `
    $ContainerName 2>$null

if ($Running -ne "true") {
    throw "O container $ContainerName nao esta em execucao."
}

Write-Host "============================================"
Write-Host "FordCare Intelligence - Database Restore"
Write-Host "============================================"

Write-Host ""
Write-Host "ATENCAO:"
Write-Host "A restauracao pode substituir dados existentes."
Write-Host ""

$Confirmation = Read-Host "Digite RESTAURAR para continuar"

if ($Confirmation -cne "RESTAURAR") {
    Write-Host "Restauracao cancelada."
    exit 0
}

Write-Host ""
Write-Host "Restaurando banco..."

Get-Content -Raw $BackupFile |
    docker exec `
        -i `
        $ContainerName `
        psql `
        -v ON_ERROR_STOP=1 `
        -U $DatabaseUser `
        -d $DatabaseName

if ($LASTEXITCODE -ne 0) {
    throw "Falha durante a restauracao."
}

Write-Host ""
Write-Host "Restauracao concluida com sucesso."