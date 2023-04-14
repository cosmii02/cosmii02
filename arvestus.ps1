 # Define variables
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

# Check for internet connection and display message
if ($ping) {
    $internetConnection = "Internet connection is available."
} else {
    $internetConnection = "Internet connection is not available."
}

# Check for valid IP address and display message
if ($ipAddress -notlike '169.*') {
    $ipMessage = "IP address: $ipAddress"
} else {
    $ipMessage = "Failed to get IP address."
}

# Create output string
$output = @"
Computer Name: $computerName
Username: $username
Operating System: $operatingSystem
Processor: $processor
Memory: $memory GB
Free Space on C drive: $freeSpaceC GB
Total Size of C drive: $totalSizeC GB
$ipMessage
MAC Address: $macAddress
Default Gateway: $defaultGateway
DNS Servers: $dnsServers
Windows Firewall Status: $firewallEnabled
Power Plan: $powerPlan
Current Date and Time: $currentDateTime
$internetConnection
"@

# Write output to console and file
Write-Host $output
$output | Out-File -FilePath 'C:\arvutiinfo.txt'
 
