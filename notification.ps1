# Vérifier si BurntToast est installé, sinon l'installer
if (-not (Get-Command "New-BurntToastNotification" -ErrorAction SilentlyContinue)) {
    Install-Module -Name BurntToast -Force -SkipPublisherCheck
}

# Afficher une notification
Import-Module BurntToast

New-BurntToastNotification -Text "Dépendances PowerShell Installées", "Les dépendances ont été installées avec succès !"

# Vous pouvez aussi afficher des messages dans la console
Write-Host "Les dépendances ont été installées avec succès."

# Si vous avez un processus d'installation, vous pouvez le déclencher ici
# Exemple fictif d'installation :
Start-Process -FilePath "C:\chemin\vers\installation.exe" -ArgumentList "/silent"
