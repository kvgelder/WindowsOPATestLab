# Error
# Failed to release DHCP lease.
# Result code: 83
# Method name: ReleaseDHCPLease

Get-NetIPInterface

$InterfaceAlias = Read-Host "Enter interface alias"
$IP = Read-Host "New IP Address"
$PrefixLength = Read-Host "Prefix length"
$DefaultGateway = Read-Host "Default Gateway"
$PrimaryDNS = Read-Host "Primary DNS Server"
$AlternateDNS = Read-Host "Alternate DNS Server"
$DNS = "" + $PrimaryDNS + "," + $AlternateDNS

Set-NetIPInterface -InterfaceAlias $InterfaceAlias -Dhcp Disabled
Remove-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress * -Confirm
New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IP -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNS