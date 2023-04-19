# Loo oma konto alt profiil
if (!(Test-Path $profile)) { New-Item -ItemType File -Path $profile -Force }

# Lisa profiilifaili personaalne tervitusteade
Set-Content $profile "`nTere tulemast, $env:UserName!`n"

# Lae alla fortune.txt fail ja salvesta see %USERPROFILE%\Documents\WindowsPowerShell\fortune.txt
$fortuneFilePath = "$env:USERPROFILE\Documents\WindowsPowerShell\fortune.txt"
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("https://raw.githubusercontent.com/bmc/devops-fortune/master/fortune.txt", $fortuneFilePath)

# Lisa profiilifaili funktsioon fortune, et kuvada teade fortune.txt failist käivitamisel
Add-Content $profile @"
function fortune {
       [System.IO.File]::ReadAllText('$fortuneFilePath') -replace "`r`n", "`n" -split "`n%`n" | Get-Random
}
fortune; echo ''
"@

# Määra profiili käsk set-location c:\, mis määrab path alguks c:\…\Desktop
Add-Content $profile "`nSet-Location C:\`n"

# Määra PowerShell akna pealkiri oma nimeks
$host.UI.RawUI.WindowTitle = "$env:UserName's PowerShell"
