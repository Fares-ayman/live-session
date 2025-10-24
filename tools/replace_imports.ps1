param([string]$Root)
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Root)) {
  Write-Host "Root path not found: $Root"
  exit 1
}

$files = Get-ChildItem -Path $Root -Recurse -Filter *.dart -File
foreach ($f in $files) {
  $content = Get-Content -Raw -LiteralPath $f.FullName
  $updated = $content -replace 'package:emaqraa_student/', 'package:live_session_app/'
  if ($updated -ne $content) {
    Set-Content -LiteralPath $f.FullName -Value $updated
  }
}

Write-Host "Done replacing imports under $Root"


