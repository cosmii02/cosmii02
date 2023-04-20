# Kenneth Tuisk | IS21

# Puhastame kõigepealt ekraani
Clear-Host

# Väljastame masina nime
Write-Host "Masina nimi: $(hostname)"
Write-Host "******************************************************"

# Väljastame operatsioonisüsteemi nime
Write-Host "Operatsioonisüsteem: $(Get-CimInstance Win32_OperatingSystem).Caption"
Write-Host "******************************************************"

# Väljastame IP-aadressid
$ips = Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ne 'Loopback Pseudo-Interface 1' -and $_.AddressState -eq 'Preferred'}
$ips | ForEach-Object {
    Write-Host "IP-aadress ($($_.InterfaceAlias)): $($_.IPAddress)"
}
Write-Host "******************************************************"

# Väljastame muutmälu suuruse
$ram = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
Write-Host ("Muutmälu suurus: {0:N2} GB" -f $ram) -ForegroundColor Yellow
Write-Host "******************************************************"

# Väljastame protsessori nime
$processor = (Get-CimInstance Win32_Processor).Name
Write-Host "Protsessor: $processor"
Write-Host "******************************************************"

# Väljastame graafikakaardi nime
$video = (Get-CimInstance Win32_VideoController).Name
Write-Host "Graafikakaart: $video"
Write-Host "******************************************************"

# Väljastame kasutajate nimed
$users = (Get-LocalUser).Name -join ', '
Write-Host "Kasutajad: $users"
Write-Host "******************************************************"
