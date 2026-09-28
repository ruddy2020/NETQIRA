param(
    [Parameter(Mandatory=$true)]
    [string]$Patch
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$PatchFull = (Resolve-Path $Patch).Path

Set-Location $Root

git apply --check $PatchFull
if ($LASTEXITCODE -ne 0) { throw "El parche no pasa git apply --check." }

git apply --whitespace=fix $PatchFull
if ($LASTEXITCODE -ne 0) { throw "No se pudo aplicar el parche." }

& (Join-Path $PSScriptRoot "check.ps1")

Write-Host "PARCHE FIGENO APLICADO Y VALIDADO" -ForegroundColor Green
