@echo off
setlocal

:: Путь для скачивания установочного файла
set "downloadPath=%TEMP%\AnyDesk.exe"

:: URL для скачивания AnyDesk
set "anyDeskUrl=https://download.anydesk.com/AnyDesk.exe"

:: Скачивание установочного файла AnyDesk
echo Downloading AnyDesk...
powershell -Command "Invoke-WebRequest -Uri '%anyDeskUrl%' -OutFile '%downloadPath%'"

:: Проверка, что файл был скачан
if not exist "%downloadPath%" (
    echo Failed to download AnyDesk installation file.
    exit /b 1
)

:: Установка AnyDesk
echo Installing AnyDesk...
"%downloadPath%" --install "C:\Program Files (x86)\AnyDesk" --start-with-win --create-desktop-icon --silent

:: Проверка успешной установки
if %ERRORLEVEL% neq 0 (
    echo Couldn't install AnyDesk.
    exit /b 1
)

:: Удаление скачанного установочного файла
del "%downloadPath%"

echo AnyDesk has been successfully installed and configured.

:: Wait for 5 seconds before closing
echo Waiting for 5 seconds before closing...
timeout /t 5 /nobreak >nul

exit /b 0
