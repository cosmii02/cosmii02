# Määra töökaust C:\Windows\Temp
Set-Location C:\Windows\Temp

# Hangi kõik .log failid, sealhulgas peidetud failid, ja sorteeri suuruse järgi kahanevalt
$failid = Get-ChildItem -Path . -Filter *.log -Recurse -Force | Sort-Object Length -Descending

# Vali ainult 3 suurimat faili
$topFailid = $failid[0..2]

# Loo uus fail nimega "Ülesanne4.txt" ja kirjuta sinna 3 suurima faili nimed, suurused ja muutmiskuupäevad
$topFailid | Select-Object Name, @{Name="Size (MB)";Expression={$_.Length/1MB}}, LastWriteTime | Format-Table -AutoSize | Out-File -FilePath Ülesanne4.txt

# Lisa lõppu oma nimi, õppegrupi tunnus ja käsk, millega teksti faili lisasid
$allkiri = "`nKenneth Tuisk, IS21, Teksti lisamise käsk: Add-Content"
Add-Content -Path Ülesanne4.txt -Value $allkiri

# Hangi praeguse kasutaja töölaua asukoht
$töölauaAsukoht = [Environment]::GetFolderPath("Desktop")

# Kopeeri "Ülesanne4.txt" fail töölauale
Copy-Item -Path ".\Ülesanne4.txt" -Destination $töölauaAsukoht
