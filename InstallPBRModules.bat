@echo off
title Install GMod-PBR-Modules (v0.1.1)
color 0A
echo --------------------------------------
echo       Installing GMod-PBR-Modules v0.1.1
echo --------------------------------------
echo.
setlocal

:: === Set default Garry's Mod path ===
set "defaultPath=C:\Program Files (x86)\Steam\steamapps\common\GarrysMod\garrysmod"
set /p "userPath=Enter the path to garrysmod folder ("GarrysMod/garrysmod") (Press Enter for default): "
if "%userPath%"=="" (
    set "userPath=%defaultPath%"
)

echo Using path: %userPath%
echo.

:: === Set temporary folder ===
set "TEMP_DIR=%TEMP%\gmod_pbr_temp"
set "ZIP_PATH=%TEMP%\pbr_0.1.1.zip"

:: === Download the archive ===
echo [1/4] Downloading v0.1.1 archive...
powershell -Command "Invoke-WebRequest -Uri https://github.com/Cpt-Hazama/GMod-PBR-Modules/archive/refs/tags/0.1.1.zip -OutFile '%ZIP_PATH%'"

if not exist "%ZIP_PATH%" (
    echo [Error] Failed to download the archive.
    pause
    exit /b
)

:: === Remove old temp folder if exists ===
if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"

:: === Extract the archive ===
echo [2/4] Extracting archive...
powershell -Command "Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%TEMP_DIR%' -Force"

:: === Check extracted folder ===
set "unpacked=%TEMP_DIR%\GMod-PBR-Modules-0.1.1"
if not exist "%unpacked%" (
    echo [Error] Extracted folder not found.
    pause
    exit /b
)

:: === Copy folders to Garry's Mod ===
echo [3/4] Copying bin, shaders, and materials...
xcopy "%unpacked%\bin" "%userPath%\bin" /E /I /Y
xcopy "%unpacked%\shaders" "%userPath%\shaders" /E /I /Y
xcopy "%unpacked%\materials" "%userPath%\materials" /E /I /Y

:: === Clean up temporary files ===
echo [4/4] Cleaning up...
del "%ZIP_PATH%" >nul 2>&1
rd /s /q "%TEMP_DIR%"

echo.
echo Installation of v0.1.1 completed successfully!
echo Files copied to: %userPath%
echo --------------------------------------
pause
endlocal
