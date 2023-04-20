# Muutujad
$firstName = "Kenneth"
$lastName = "Tuisk"
$email = "kenneth.tuisk@vikk.ee"
$date = Get-Date -Format "yyyy-MM-dd"
$fileName = "skriptimine_$date.txt"

# Väljund
$output = "Minu eesnimi on $firstName ja perekonnanimi on $lastName.`n"
$output += "Minu kooli email on $email.`n"
$output += "Tänane kuupäev on $date ja failinimi on $fileName.`n"

Write-Host "`n----------------------`n" -ForegroundColor Green
Write-Host $output

# Salvesta fail Desktopile
$path = "C:\Users\$env:USERNAME\Desktop\$fileName"
Set-Content -Path $path -Value $output

# Lisa lõppu teade
Add-Content -Path $path -Value "`nSee on hea päev skriptimiseks!"

# Kuva teavet salvestatud faili kohta
$location = "C:\Users\$env:USERNAME\Desktop"
Write-Host "`nFail '$fileName' on loodud asukohta: $location" -ForegroundColor Yellow
