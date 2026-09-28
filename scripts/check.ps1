$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$App = Join-Path $Root "app"
Set-Location $App

flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get falló." }

dart format --output=none --set-exit-if-changed lib test
if ($LASTEXITCODE -ne 0) { throw "dart format detectó archivos sin formatear." }

flutter analyze
if ($LASTEXITCODE -ne 0) { throw "flutter analyze falló." }

flutter test
if ($LASTEXITCODE -ne 0) { throw "flutter test falló." }

Write-Host "CHECK FIGENO OK" -ForegroundColor Green
