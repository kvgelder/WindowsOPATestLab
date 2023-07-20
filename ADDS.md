# Active Directory Domain Services

## Multi server domain
### New Active Directory forest and domain controller.
Start by setting up a new forest and domain controller via the `Install-ADDSForest` command.
Make sure the DomainMode and ForestMode are set correctly.
```PowerShell
# Input variables
$DomainName = “[FQDN]” # Change [FQDN] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSForest -DomainName $DomainName -DomainMode Windows2016Domain -ForestMode Windows2016Forest -InstallDns
```

### Setting up an Active Directory domain controller member.
To set up a domain controller member server, make use of the `Install-ADDSDomainController` command.
```PowerShell
$DomainName = "[FQDN]" # Change [FQDN] to match your environment.
$Credentials =  Get-Credential [NETBIOS NAME]\Administrator # Change [NETBIOS NAME] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSDomainController -DomainName $DomainName -InstallDns -Credential $Credentials
```

#### Run Active Directory Domain Services health checks
Running the following health checks will allow you to check whether Domain has been configured as necessary.
Make sure the FSMO roles are located on the correct domain controller, for example.
```PowerShell
function Read-UserInputToContinue {
    if ($psISE) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Press OK to continue...")
    } else {
        Write-Host -NoNewLine 'Press any key to continue...'
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    }
}

# Shows domain controller information of the current server
Write-Host "Check domain controller information."
Get-ADDomainController -Discover
Read-UserInputToContinue

# Active Directory services that need to be running.
Write-Host "Check running Active Directory services."
Get-Service adws,kdc,netlogon,dns
Read-UserInputToContinue

# Hidden shares that must be available. SYSVOL and NETLOGON shares.
Write-Host "Check if the SYSVOL and NETLOGON SMB shares are available."
Get-SMBshare
Read-UserInputToContinue

# Check replication between domain controllers.
Write-Host "Check if replication between domain controllers is working."
Repadmin /replsummary
Read-UserInputToContinue

# Analyze the state of the domain controllers in the forest.
Write-Host "Analyze the state of the domain controller in the current forest."
dcdiag
Read-UserInputToContinue

# Displays where the Flexible Single Master Operation roles are located.
Write-Host "Check where the FSMO roles are located."
Netdom /query FSMO
Read-UserInputToContinue
```