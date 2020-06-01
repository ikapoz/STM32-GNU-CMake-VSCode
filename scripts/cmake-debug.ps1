$currentPath = Get-Location
Write-Host "Current path: $currentPath"
$sourceDir = Get-Location
$buildDir = "$sourceDir/build"
$stm32UtilsPath = Resolve-Path "$sourceDir/../stm32-utils"
$cmake = Resolve-Path "$stm32UtilsPath/cmake/bin/cmake.exe"
$make = Resolve-Path "$stm32UtilsPath/make.exe"
$toolchainCmakeFile = Resolve-Path "$sourceDir/cmake/toolchain.cmake"

if (!(Test-Path $buildDir)) {
    New-Item -ItemType Directory -Force -Path $buildDir
}

Write-Host "Creating Make file if not exists"
Write-Host "Commend $cmake -S $sourceDir  Toolchain_file=$toolchainCmakeFile MAKE_PROGRAM_PATH=$make " 
& $cmake -S $sourceDir -B $buildDir -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="$toolchainCmakeFile" -D"CMAKE_MAKE_PROGRAM:PATH=$make" -DCMAKE_BUILD_TYPE=Debug -Wdev --log-level=DEBUG
Write-Host "Building the project"
& $cmake --build $buildDir -j 4 -v