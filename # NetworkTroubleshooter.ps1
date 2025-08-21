# NetworkTroubleshooter.ps1
# Author: Amaljith A
# Description: A simple network troubleshooting script for IT Support

# Get date and log file path
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = "$env:USERPROFILE\Desktop\Network_Troubleshoot_$timestamp.log"

Write-Output "Network Troubleshooting Script Started - $timestamp" | Tee-Object -FilePath $logFile -Append

# Check IP configuration
Write-Output "`n=== IP Configuration ===" | Tee-Object -FilePath $logFile -Append
ipconfig /all | Tee-Object -FilePath $logFile -Append

# Ping default gateway
Write-Output "`n=== Ping Default Gateway ===" | Tee-Object -FilePath $logFile -Append
$gateway = (Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null}).IPv4DefaultGateway.NextHop
if ($gateway) {
    ping $gateway | Tee-Object -FilePath $logFile -Append
} else {
    Write-Output "No default gateway found." | Tee-Object -FilePath $logFile -Append
}

# Ping Google DNS
Write-Output "`n=== Ping Google DNS (8.8.8.8) ===" | Tee-Object -FilePath $logFile -Append
ping 8.8.8.8 | Tee-Object -FilePath $logFile -Append

# Test DNS resolution
Write-Output "`n=== DNS Resolution Test (google.com) ===" | Tee-Object -FilePath $logFile -Append
nslookup google.com | Tee-Object -FilePath $logFile -Append

# Traceroute to Google
Write-Output "`n=== Traceroute to Google (google.com) ===" | Tee-Object -FilePath $logFile -Append
tracert google.com | Tee-Object -FilePath $logFile -Append

# Show active network connections
Write-Output "`n=== Active Network Connections ===" | Tee-Object -FilePath $logFile -Append
netstat -ano | Tee-Object -FilePath $logFile -Append

Write-Output "`nNetwork Troubleshooting Script Completed. Log saved at $logFile" | Tee-Object -FilePath $logFile -Append
