# Leia abitekst Get-Service käsu kohta
Get-Help Get-Service

# Leia abitekstist üles, kuidas saab kätte näited
Get-Help Get-Service -Examples

# Leia näidete hulgast vihje, kuidas otsida teenuseid, mis sisaldab sõna network
Get-Help Get-Service -Examples | Select-String -Pattern "network"

# Vorminda saadud tulemus tabelina (format-table) ja kuva ainult "Status" ja "Name" veerud
Get-Service | Where-Object {$_.Name -like "*network*"} | Format-Table Name,Status

# Väljasta saadud tulemus tekstifaili "Ülesanne3.txt" (out-file)
Get-Service | Where-Object {$_.Name -like "*network*"} | Format-Table Name,Status | Out-File -FilePath C:\Users\TeieKasutajanimi\Desktop\Ülesanne3.txt

# Kontrolli, kas tulemus tekkis faili käsuga Get-Content <failinimi>
Get-Content C:\Users\TeieKasutajanimi\Desktop\Ülesanne3.txt
