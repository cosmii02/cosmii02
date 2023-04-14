# Defineerime muutujad
$computerName = $env:COMPUTERNAME
$username = $env:USERNAME
$operatingSystem = (Get-CimInstance Win32_OperatingSystem).Caption
$processor = (Get-CimInstance Win32_Processor).Name
$memory = [Math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB, 2)
$freeSpaceC = [Math]::Round((Get-CimInstance Win32_LogicalDisk -Filter 'DeviceID="C:"').FreeSpace / 1GB, 2)
$totalSizeC = [Math]::Round((Get-CimInstance Win32_LogicalDisk -Filter 'DeviceID="C:"').Size / 1GB, 2)
$ipConfig = Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null}
$ipAddress = $ipConfig.IPv4Address.IPAddress
$macAddress = (Get-NetAdapter | Where-Object {$_.InterfaceAlias -eq 'Ethernet'}).MacAddress
$defaultGateway = (Get-NetRoute | Where-Object {$_.DestinationPrefix -eq '0.0.0.0/0' -and $_.AddressFamily -eq 'IPv4'}).NextHop
$dnsServers = (Get-DnsClientServerAddress).ServerAddresses
$firewallEnabled = (Get-NetFirewallProfile).Enabled
$powerPlan = (powercfg /getactivescheme | Select-String ':\s*(.*)$' | ForEach-Object {$_.Matches.Groups[1].Value})
$currentDateTime = Get-Date
$ping = Test-Connection -ComputerName google.com -Count 1 -Quiet

# Kontrollime internetiühendust ja väljastame vastava teate
if ($ping) {
    $internetConnection = "Internetiühendus on saadaval."
} else {
    $internetConnection = "Internetiühendus puudub."
}

# Kontrollime, kas IP-aadress on kehtiv ja väljastame vastava teate
if ($ipAddress -notlike '169.*') {
    $ipMessage = "IP-aadress: $ipAddress"
} else {
    $ipMessage = "IP-aadressi hankimine ebaõnnestus."
}

# Loome väljundstringi
$output = @"
Arvuti nimi: $computerName
Kasutajanimi: $username
Operatsioonisüsteem: $operatingSystem
Protsessor: $processor
Mälu: $memory GB
Vaba ruumi kettal C: $freeSpaceC GB
Ketta C suurus: $totalSizeC GB
$ipMessage
MAC-aadress: $macAddress
Vaikimisi värav: $defaultGateway
DNS-serverid: $dnsServers
Windowsi tulemüüri olek: $firewallEnabled
Toiteplaani seadistus: $powerPlan
Praegune kuupäev ja kellaaeg: $currentDateTime
$internetConnection
"@

# Väljastame väljundi konsoolile ja salvestame faili
Write-Host $output
$output | Out-File -FilePath 'C:\arvutiinfo.txt'
