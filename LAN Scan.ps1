# Get the local computer's IP address on the LAN using ipconfig
$ipconfigOutput = ipconfig
$localIPAddress = ($ipconfigOutput | Select-String -Pattern 'IPv4 Address' | ForEach-Object { ($_ -split ': ')[1] })[0]

# Get information about devices on the local network using ARP.exe
$arpTable = & "ARP.exe" "-a"

# Split the ARP table output into lines
$arpTableLines = $arpTable -split "`r`n"

# Display information for each device in the ARP table
foreach ($line in $arpTableLines) {
    if ($line -match '\s+(\d+\.\d+\.\d+\.\d+)\s+(\S+)\s+(\S+)') {
        $ipAddress = $matches[1]
        $macAddress = $matches[2]
        $deviceName = $matches[3]
        Write-Host "Device Name: $deviceName"
        Write-Host "IP Address: $ipAddress"
        Write-Host "MAC Address: $macAddress"
        Write-Host "-------------------"
    }
}

# Display the local IP address
Write-Host "Local IP Address: $localIPAddress"