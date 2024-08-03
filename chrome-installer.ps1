# Путь для скачивания установочного файла
$downloadPath = "$env:TEMP\chrome_installer.exe"

# Функция для скачивания установочного файла
function Download-ChromeInstaller {
    param (
        [string]$path
    )
    $url = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    try {
        Invoke-WebRequest -Uri $url -OutFile $path
        Write-Output "Установочный файл скачан: $path"
    }
    catch {
        Write-Error "Не удалось скачать установочный файл: $_"
    }
}

# Функция для установки Chrome
function Install-Chrome {
    param (
        [string]$installerPath
    )
    try {
        Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -NoNewWindow -Wait
        Write-Output "Google Chrome успешно установлен."
    }
    catch {
        Write-Error "Не удалось установить Google Chrome: $_"
    }
}

# Скачивание установочного файла
Download-ChromeInstaller -path $downloadPath

# Установка Chrome
Install-Chrome -installerPath $downloadPath
