$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$App = Join-Path $Root "app"

Set-Location $App

flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get fallo." }

dart format lib test
if ($LASTEXITCODE -ne 0) { throw "dart format fallo." }

flutter analyze
if ($LASTEXITCODE -ne 0) { throw "flutter analyze fallo." }

flutter test
if ($LASTEXITCODE -ne 0) { throw "flutter test fallo." }

flutter build apk --debug
if ($LASTEXITCODE -ne 0) { throw "flutter build apk --debug fallo." }

$Apk = Join-Path $App "build\app\outputs\flutter-apk\app-debug.apk"
if (-not (Test-Path $Apk)) {
    throw "No se encontro app-debug.apk."
}

Write-Host "CHECK FIGENO ANDROID OK" -ForegroundColor Green
Write-Host "APK: $Apk"