$currentPath = Get-Location
$buildDir = Resolve-Path "$currentPath/../build"

if (Test-Path $buildDir) {
    Write-Host "deleting build folder"
    Remove-Item $buildDir -Recurse
}