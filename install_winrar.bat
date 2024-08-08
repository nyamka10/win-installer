@echo off

REM Navigate to the temporary directory
cd %TEMP%

REM Download WinRAR installer
echo Downloading WinRAR...
curl -L -o winrar-x64-701ru.exe https://github.com/nyamka10/win-installer/raw/main/winrar-x64-701ru.exe

REM Download the activation key
echo Downloading activation key...
curl -L -o rarreg.key https://raw.githubusercontent.com/nyamka10/win-installer/main/rarreg.key

REM Install WinRAR in silent mode
echo Installing WinRAR...
winrar-x64-701ru.exe /S

REM Copy the activation key to the WinRAR installation directory
echo Activating WinRAR...
copy rarreg.key "C:\Program Files\WinRAR" /Y

REM Notify the user of successful installation and activation
echo WinRAR has been successfully installed and activated!

REM Wait for 5 seconds before closing the CMD window
timeout /t 5 /nobreak >nul

REM Close the CMD window
exit
