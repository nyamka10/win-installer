@echo off
:: Step 1: Check Windows activation status
echo Checking Windows activation status...
powershell -Command "((Get-WmiObject -query 'select * from SoftwareLicensingProduct where PartialProductKey is not null and LicenseStatus = 1').Name) > activation_status.txt"

:: Check if activation status file is empty
setlocal enabledelayedexpansion
set activated=no
for /f %%i in (activation_status.txt) do set activated=yes

if "%activated%"=="no" (
    echo Windows is not activated. Activating Windows...
    powershell -Command "& {& ([ScriptBlock]::Create((irm https://get.activated.win))) /KMS-Windows /KMS-ActAndRenewalTask /S}"
) else (
    echo Windows is already activated.
)

:: Clean up
del activation_status.txt

:: Wait for 5 seconds before closing
echo Waiting for 5 seconds before closing...
timeout /t 5 /nobreak >nul

exit
