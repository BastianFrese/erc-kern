# Baut die geänderte Kern-CLI reproduzierbar aus dem veröffentlichten Quelltext.
#
#   powershell -ExecutionPolicy Bypass -File bauen.ps1
#
# Ergebnis: .\arbeit\SwoftyLauncher\target\release\swofty.exe
$ErrorActionPreference = "Stop"

$fassung = "v1.7.5"
$hier = Split-Path -Parent $MyInvocation.MyCommand.Path
$arbeit = Join-Path $hier "arbeit"
$quelle = Join-Path $arbeit "SwoftyLauncher"

New-Item -ItemType Directory -Force $arbeit | Out-Null

if (Test-Path $quelle) {
    Push-Location $quelle
    git fetch --depth 1 origin "refs/tags/$fassung"
    git checkout -f FETCH_HEAD
    Pop-Location
} else {
    git clone --depth 1 --branch $fassung https://github.com/Swofty-Developments/SwoftyLauncher.git $quelle
}

Push-Location $quelle
try {
    git apply (Join-Path $hier "aenderungen.patch")
    cargo build --release -p swofty-cli
    $exe = Join-Path $quelle "target\release\swofty.exe"
    Write-Output "Gebaut: $exe"
    & $exe --version
} finally {
    Pop-Location
}
