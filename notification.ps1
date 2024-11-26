# V�rifier si BurntToast est install�, sinon l'installer
if (-not (Get-Command "New-BurntToastNotification" -ErrorAction SilentlyContinue)) {
    Install-Module -Name BurntToast -Force -SkipPublisherCheck
}

# Afficher une notification
Import-Module BurntToast

New-BurntToastNotification -Text "D�pendances PowerShell Install�es", "Les d�pendances ont �t� install�es avec succ�s !"

# Vous pouvez aussi afficher des messages dans la console
Write-Host "Les d�pendances ont �t� install�es avec succ�s."

# Si vous avez un processus d'installation, vous pouvez le d�clencher ici
# Exemple fictif d'installation :
Start-Process -FilePath "C:\chemin\vers\installation.exe" -ArgumentList "/silent"
