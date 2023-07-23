# Trusted Hosts
## General information
There are a few ways to add computers to the WSMan TrustedHosts list.
1. Setting the list to contain specific a specfic IP address(es).
2. Setting the TrustedHosts list to allow all computers.
3. Setting the TrustedHosts list to only allow domain joined computers.

Besides different ways to add computers to the TrustedHosts list, there are also a couple of different ways to modify the existing list.
1. Setting the list to the specified value.
2. Concatenating the specified values to the exsisting TrustedHosts values.

### Checking the existing configuration
To check the current TrustedHosts list configuration and figure out which devices are currently allow to remotely manage the server, you will have to use the `Get-Item` command.
```PowerShell
Get-Item WSMan:\localhost\Client\TrustedHosts

Get-Item WSMan:\localhost\Client\TrustedHosts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   TrustedHosts                                   10.10.10.1
```
In the example above we set the TrustedHosts list to contain the device which is assigned the IP address 10.10.10.1.

### Setting the WSMan Trusted Hosts list to match a specific IP address or device.
To set the TrustedHosts list with a specific IP address, you will have the `Set-Item` command with the `-Value [VALUE]` parameter.
```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 10.10.10.100

Get-Item WSMan:\localhost\Client\TrustedHosts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   TrustedHosts                                   10.10.10.100
```
By using `Set-Item`, the TrustedHosts list is now set to the IP address 10.10.10.100.
The pre existing IP address of 10.10.10.1 has been overwritten.

### Adding a new value to an existing TrustedHosts list configuration.
In case a new device needs to be added to the TrustedHosts list, but the TrustedHosts list already contains a set of devices, using the `-Concatenate` parameter is key.
```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Concatenate -Value 10.10.10.200

Get-Item WSMan:\localhost\Client\TrustedHosts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   TrustedHosts                                   10.10.10.100,10.10.10.200
```
By using the `-Concatenate` parameter the specified `-Value` will be added to the existing TrustedHosts list.

### Adding all domain joined devices to the TrustedHosts list.
Adding all domain joined devices to the TrustedHosts list is a straight forward configuration.
```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts *.[FQDN]
```

### Removing values from the TrustedHosts list configuration.
Removing specific addresses is a little bit more difficult.
But to simplify things we can make use of the Regex feature and built-in $Matches Hashtable.
```PowerShell
Get-Item WSMan:\localhost\Client\TrustedHosts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   TrustedHosts                                   10.10.10.100,10.10.10.200

$List = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value
# If statement that checks if list matches ',[IP]' and '[IP]'. 
# If the IP address is first in the list of values, the trailing ',' will have to be removed.
$List -match ',?10.10.10.200'
# We check for ,192.168.88.102 in case the IP address we are looking for is not the only IP address in the list.
# Otherwise the preceeding ',' will be left in the list which could cause problems. 
# This could also be a computer name instead of an IP address.
$List = $List.Replace($Matches.0, '') # Replace the found string with nothing.
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $List # Set the TrustedHosts list to match our edited list.

Get-Item WSMan:\localhost\Client\TrustedHosts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   TrustedHosts                                   10.10.10.100
```