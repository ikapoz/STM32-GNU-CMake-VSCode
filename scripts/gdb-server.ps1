$currentPath = Get-Location
$stm32_utils = Resolve-Path "$currentPath\\..\\stm32-utils"
$stm32ProgrammerPath =  "$stm32_utils\\stm32-tools\\bin"
$st_link = "$stm32_utils\\st-link\\ST-LINK_gdbserver.exe"
$arguments = "-l 31 -s -d -cp $stm32ProgrammerPath"
## rebuild everyhting
& .\scripts\cmake-debug.ps1

## start GDB server 
Start-Process -FilePath $st_link $arguments -Verbose