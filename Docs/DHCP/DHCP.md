# Windows DHCP Server
## Installing DHCP
### Configuring basic DHCP functionality
The Windows Server DHCP role can be installed using the `Install-WindowsFeature` command in PowerShell.

```PowerShell
Get-WindowsFeature *DHCP*

Display Name            Name        Install State
------------            ----        -------------
[ ] DHCP Server         DHCP        Available
[ ] DHCP Server Tools   RSAT-DHCP   Available

Install-WindowsFeature DHCP -IncludeManagementTools -IncludeAllSubFeature
```
  
After the installation is complete the following needs to be configured to enable basic DHCP functionality.
1. Create a DHCP server using `Add-DhcpServerInDC`.
2. Configure an IPv4/IPv6 scope using `Add-DhcpServerv4Scope`.

First creating a DHCP server and authorizing the DHCP server within the Domain.
```PowerShell
Add-DhcpServerInDc -DnsName hostname.testdomain.com -IPAddress 172.16.0.3

Get-DhcpServerInDC

IPAddress           DnsName
---------           -------
172.16.0.3          hostname.testdomain.com
```

Now we can add a scope to the newly created DHCP server.
This will create a new scope with network address 172.16.0.0 and a subnet mask of /24.
```PowerShell
Add-DhcpServerv4Scope -Name "Test Domain Network" -StartRange 172.16.0.1 -EndRange 172.16.0.254 -SubnetMask 255.255.255.0

Get-DhcpServerv4Scope | Format-Table -Wrap -AutoSize

ScopeId         SubnetMask    Name                   State  StartRange     EndRange        LeaseDuration
-------         ----------    ----                   -----  ----------     --------        -------------
172.16.0.0      255.255.255.0 Test Domain Network    Active 172.16.0.1     172.16.0.254    8.00:00:00
```

### Additional DHCP configuration options
#### DHCP Exclusions
To exclude a certain IP range for use with hosts that require a static ip, use the `Add-DhcpServerv4ExclusionRange`.
```PowerShell
# Optionally, use the -ComputerName parameter to target a specific scope on a specific dhcp host.
Add-DhcpServerv4ExclusionRange -ScopeId 172.16.0.0 -StartRange 172.16.0.1 -EndRange 172.16.0.50 

Get-DhcpServerv4ExclusionRange -ScopeId 172.16.0.0

ScopeId        StartRange     EndRange
-------        ----------     --------
172.16.0.0     172.16.0.1     172.16.0.50
```
#### DHCP Reservations
Creating DHCP reservations for specific hosts can be done using the `Add-DhcpServerV4Reservation` command.
```PowerShell
Add-DhcpServerv4Reservation -ScopeId 172.16.0.0 -IPAddress 172.16.0.3 -ClientId "00-11-22-33-44-55"

Get-DhcpServerV4Reservation -ScopeId 172.16.0.0

IPAddress       ScopeId         ClientId
---------       -------         --------
172.16.0.3      172.16.0.0      172.16.0.0
```