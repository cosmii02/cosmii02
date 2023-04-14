Write-Host "Computer Name: $($env:COMPUTERNAME)"
Write-Host "Username: $($env:USERNAME)"
Write-Host "Operating System: $(Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption)"
Write-Host "Processor: $(Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name)"
Write-Host "Memory: $([Math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB, 2)) GB"
Write-Host "Free Space on C drive: $([Math]::Round((Get-CimInstance Win32_LogicalDisk -Filter 'DeviceID=''C:''').FreeSpace / 1GB, 2)) GB"
Write-Host "Total Size of C drive: $([Math]::Round((Get-CimInstance Win32_LogicalDisk -Filter 'DeviceID=''C:''').Size / 1GB, 2)) GB"
Write-Host "IP Address: $(Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq 'Ethernet' -and $_.AddressFamily -eq 'IPv4'} | Select-Object -ExpandProperty IPAddress)"
Write-Host "MAC Address: $(Get-NetAdapter | Where-Object {$_.InterfaceAlias -eq 'Ethernet'} | Select-Object -ExpandProperty MacAddress)"
Write-Host "Default Gateway: $(Get-NetRoute | Where-Object {$_.DestinationPrefix -eq '0.0.0.0/0' -and $_.AddressFamily -eq 'IPv4'} | Select-Object -ExpandProperty NextHop)"
Write-Host "DNS Servers: $(Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses)"
Write-Host "Windows Firewall Status: $(Get-NetFirewallProfile | Select-Object -ExpandProperty Enabled)"
Write-Host "Power Plan: $(powercfg /getactivescheme | Select-String ':\s*(.*)$' | ForEach-Object {$_.Matches.Groups[1].Value})"
Write-Host "Current Date and Time: $(Get-Date)"

# Check for internet connection using ping command
$ping = Test-Connection -ComputerName google.com -Count 1 -Quiet
if ($ping) {
    Write-Host "Internet connection is available."
} else {
    Write-Host "Internet connection is not available."
}
