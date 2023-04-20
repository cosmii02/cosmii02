# Create a PowerShell profile if it does not exist
if (!(Test-Path $profile)) { New-Item -ItemType File -Path $profile -Force }

# Add a personalized greeting to the profile
Write-Host "Tere tulemast, $env:UserName!"

# Make sure the Desktop folder exists
$desktopPath = "$env:USERPROFILE\Desktop"
if (!(Test-Path $desktopPath)) { New-Item -ItemType Directory -Path $desktopPath }

# Add the fortune function to the profile to display a message from the fortune file on startup
Add-Content $profile @"
function fortune {
       [System.IO.File]::ReadAllText('C:/fortune.txt') -replace "`r`n", "`n" -split "`n%`n" | Get-Random
}
fortune; echo ''
"@

# Set the default location to the Desktop
Add-Content $profile "`nSet-Location $desktopPath`n"

# Set the console window title to "Kenneth's PowerShell"
$host.UI.RawUI.WindowTitle = "Kenneth's PowerShell"

# Pause to keep the console window open
pause
