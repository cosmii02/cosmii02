# Define the desktop location as an environment variable
$Desktop = "$env:USERPROFILE\Desktop"

# Get help information for the Get-Service cmdlet
Get-Help Get-Service

# Display examples for the Get-Service cmdlet
Get-Help Get-Service -Examples

# Filter the examples to display only those that include the word "network"
Get-Help Get-Service -Examples | Select-String -Pattern "network"

# Format the results as a table and display only the Name and Status columns
Get-Service | Where-Object {$_.Name -like "*network*"} | Format-Table Name, Status

# Save the results to a text file named "Ülesanne3.txt" on the user's desktop
Get-Service | Where-Object {$_.Name -like "*network*"} | Format-Table Name, Status | Out-File -FilePath "$Desktop\Ülesanne3.txt"

# Verify that the file was created by reading its contents using Get-Content
Get-Content "$Desktop\Ülesanne3.txt"
