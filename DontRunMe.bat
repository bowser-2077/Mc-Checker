@echo off
setlocal enabledelayedexpansion

:: Format de la date et de l'heure
for /f "tokens=1,2 delims=/ " %%a in ("%date%") do (
    set day=%%a
    set month=%%b
    set year=%%c
)

:: Correction de l'heure (enlever les caractères invalides)
for /f "tokens=1,2 delims=:." %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
    set second=%%c
)

:: Remplacer les caractères invalides dans l'heure
set hour=%hour::=-%
set minute=%minute::=-%
set second=%second::=-%

:: Créer un fichier de log unique avec la date et l'heure
set LOG_FILE=C:\MinecraftLogs\Script.%year%-%month%-%day%_%hour%-%minute%-%second%.log

:: Créer le dossier de logs s'il n'existe pas
if not exist C:\MinecraftLogs mkdir C:\MinecraftLogs

:: Log initial - Début du script
echo [%date% %time%] Script démarré >> %LOG_FILE%

:: Ajouter une autre action à loguer, exemple : Lancement du script
echo [%date% %time%] Chargement du script... >> %LOG_FILE%

:: Afficher les informations pour l'utilisateur
echo LOADING SCRIPT...........
timeout /t 4 > NUL
echo LOADING POWERSHELL SYSTEM..........
timeout /t 3 > NUL
echo LOADING ASSETS..........
timeout /t 2 > NUL
echo FINALIZING..........
timeout /t 5 > NUL
echo LOADING API (can take a while)..........
timeout /t 7 > NUL
echo TRIGGERING API...........
timeout /t 1 > NUL
echo API LOAD 15%...........
timeout /t 1 > NUL
echo UNABLE TO CHECK DEPENDENCIES
echo PLEASE CHECK BY YOURSELF..........
timeout /t 5 > NUL
echo WELCOME! (UI CAN TAKE A WHILE TO LOAD)
timeout /t 1 > NUL
cls

:: Log de l'affichage du menu
echo [%date% %time%] Menu affiché. >> %LOG_FILE%

:: Menu principal
:menu
cls
color 1F
echo ==============================
echo    Minecraft Server Checker
echo ==============================
echo 1. Modifier l'IP du serveur
echo 2. Lancer la recherche
echo 3. Installer le système de notification
echo 4. Recharger le script
echo 5. Quitter
echo ==============================
set /p choice="Choisissez une option (1-5) : "

:: Log de la sélection de l'utilisateur
echo [%date% %time%] Choix de l'utilisateur : %choice% >> %LOG_FILE%

if "%choice%"=="1" goto :modip
if "%choice%"=="2" goto :search
if "%choice%"=="3" goto :install_dependencies_and_requirements
if "%choice%"=="4" goto :reload
if "%choice%"=="5" exit

:: Modifier l'IP du serveur
:modip
cls
color 1F
echo Entrez l'adresse du serveur Minecraft (ex: play.example.com):
set /p "server=Adresse du serveur: "
echo [%date% %time%] IP du serveur modifiée à : %server% >> %LOG_FILE%
goto :menu

:: Lancer la recherche
:search
:: Vérifie si l'IP du serveur est définie
if not defined server (
    echo [%date% %time%] L'IP du serveur n'est pas définie. Retour au menu... >> %LOG_FILE%
    timeout /t 2 > nul
    goto :menu
)

:: Vérifie si curl est installé
where curl > nul 2>&1
if %errorlevel% neq 0 (
    color 4F
    echo [%date% %time%] Erreur: curl n'est pas installé sur ce système. >> %LOG_FILE%
    pause
    exit /b
)

:: Récupère les informations du serveur
echo [%date% %time%] Début de la vérification de l'état du serveur %server% >> %LOG_FILE%
curl -s "https://api.mcsrvstat.us/2/%server%" > response.json
if %errorlevel% neq 0 (
    color 4F
    echo [%date% %time%] Erreur lors de la récupération des données du serveur %server%. >> %LOG_FILE%
    goto :error
)

:: Vérifie si le fichier JSON a été créé
if not exist response.json (
    color 4F
    echo [%date% %time%] Impossible de récupérer les informations du serveur %server%. >> %LOG_FILE%
    goto :error
)

:: Vérifie si le serveur est en ligne
findstr /i "\"online\":true" response.json > nul
if %errorlevel%==0 (
echo SERVER ONLINE!
    color 2F
    echo [%date% %time%] Le serveur %server% est en ligne. >> %LOG_FILE%
) else (
echo SERVER OFFLINE!
    color 4F
    echo [%date% %time%] Le serveur %server% est hors ligne. >> %LOG_FILE%
)

:: Nettoyage
del response.json

:: Attendre avant de revenir au menu
pause
goto :menu

:: Installer les dépendances et requirements
:install_dependencies_and_requirements
cls
color 1F
echo Installation des dépendances PowerShell et des requirements...
echo [%date% %time%] Installation des dépendances et requirements commence... >> %LOG_FILE%
"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ExecutionPolicy Bypass -File "C:\Users\%USER%\Downloads\McChecker\notification.ps1"
echo [%date% %time%] Dépendances installées. >> %LOG_FILE%
echo.
pause
goto :menu

:: Recharger le script
:reload
cls
color 2
echo Rechargement du script...
timeout /t 2 > nul
call "%~f0"

:: Gestion des erreurs
:error
cls
color 4F
echo Une erreur est survenue. Veuillez vérifier l'IP du serveur ou votre connexion Internet.
echo [%date% %time%] Une erreur est survenue lors de la vérification du serveur. >> %LOG_FILE%
pause > nul
goto :menu
