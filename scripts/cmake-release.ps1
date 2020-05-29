$currentPath = Get-Location
$sourceDir = $currentPath
$buildDir = "$sourceDir/build/release"
$stm32UtilsPath = Resolve-Path "$sourceDir/../stm32-utils"
$cmake = Resolve-Path "$stm32UtilsPath/cmake/bin/cmake.exe"
$make = Resolve-Path "$stm32UtilsPath/make.exe"
$toolchainCmakeFile = Resolve-Path "$sourceDir/cmake/toolchain.cmake"

if (Test-Path $buildDir) {
    Remove-Item $buildDir -Recurse
}

New-Item -ItemType Directory -Force -Path $buildDir

Write-Host "Creating Make file if not exists"
& $cmake -S $sourceDir -B $buildDir -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="$toolchainCmakeFile" -D"CMAKE_MAKE_PROGRAM:PATH=$make" -DCMAKE_BUILD_TYPE=Release 
Write-Host "Building the project"
& $cmake --build $buildDir -j 4 -v