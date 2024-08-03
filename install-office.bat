@echo off
setlocal

:: Path for downloading files
set "downloadPath=%TEMP%"

:: URL for downloading setup.exe
set "setupUrl=https://github.com/nyamka10/win-installer/raw/main/setup.exe"

:: URL for downloading office 2021.xml
set "configUrl=https://raw.githubusercontent.com/nyamka10/win-installer/main/office2021.xml"

:: Download setup.exe
echo Downloading setup.exe...
powershell -Command "Invoke-WebRequest -Uri '%setupUrl%' -OutFile '%downloadPath%\setup.exe'"

:: Check if setup.exe was downloaded
if not exist "%downloadPath%\setup.exe" (
    echo Failed to download setup.exe.
    pause
    exit /b 1
)

:: Download office 2021.xml
echo Downloading office 2021.xml...
powershell -Command "Invoke-WebRequest -Uri '%configUrl%' -OutFile '%downloadPath%\office2021.xml'"

:: Check if office 2021.xml was downloaded
if not exist "%downloadPath%\office2021.xml" (
    echo Failed to download office 2021.xml.
    pause
    exit /b 1
)

:: Start the installation
echo Starting installation...
cd /d "%downloadPath%"
setup.exe /configure "office2021.xml"

:: Check if the installation was successfully started
if %ERRORLEVEL% neq 0 (
    echo Failed to start the installation.
    pause
    exit /b 1
)

:: Activate Office
echo Activating Office...
powershell -Command "& {& ([ScriptBlock]::Create((irm https://get.activated.win))) /KMS-Office /KMS-ActAndRenewalTask}"

:: Check activation status
echo Checking Office activation status...
powershell -Command "cscript \"%ProgramFiles%\Microsoft Office\Office16\OSPP.VBS\" /dstatus"

echo Installation successfully started.

:: Wait for 5 seconds before closing
echo Waiting for 5 seconds before closing...
timeout /t 5 /nobreak >nul

exit /b 0
