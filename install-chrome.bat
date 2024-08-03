@echo off
setlocal

:: Path for downloading the installer file
set "downloadPath=%TEMP%\chrome_installer.exe"

:: Function to download the installer file
echo Downloading Google Chrome installer...
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile '%downloadPath%'"
if %ERRORLEVEL% neq 0 (
    echo Failed to download the installer file.
    exit /b %ERRORLEVEL%
)

echo Installer file downloaded: %downloadPath%

:: Function to install Chrome
echo Installing Google Chrome...
start /wait "" "%downloadPath%" /silent /install
if %ERRORLEVEL% neq 0 (
    echo Failed to install Google Chrome.
    exit /b %ERRORLEVEL%
)

echo Google Chrome installed successfully.

:: Clean up the installer file (optional)
:: del "%downloadPath%"

echo Installation complete. Waiting for 5 seconds before exiting...
timeout /t 5 /nobreak >nul

endlocal
