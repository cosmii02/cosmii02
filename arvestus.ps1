# Get system information
$sysInfo = @{
    "Operating System" = (Get-CimInstance Win32_OperatingSystem).Caption
    "Architecture" = (Get-CimInstance Win32_Processor).AddressWidth.ToString() + "-bit"
    "Processor" = (Get-CimInstance Win32_Processor).Name
    "RAM" = "{0:N2} GB" -f ((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    "Hard Drive Size" = "{0:N2} GB" -f ((Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB)
    "Hard Drive Free Space" = "{0:N2} GB" -f ((Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB)
    "Display Resolution" = (Get-CimInstance Win32_VideoController).VideoModeDescription
    "MAC Address" = (Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null }).MACAddress
    "IP Address" = (Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null }).IPAddress[0]
}

# Check internet connection
if (Test-Connection -ComputerName www.google.com -Count 1 -Quiet) {
    Write-Host "Internet connection: Connected"
} else {
    Write-Host "Internet connection: Disconnected"
}

# Check DHCP server for IP address
if ($sysInfo["IP Address"].StartsWith("169.")) {
    Write-Host "IP address: Failed to get DHCP server assigned IP address"
} else {
    Write-Host "IP address:" $sysInfo["IP Address"]
}

# Write system information to file
$sysInfo | Out-File C:\arvutiinfo.txt
