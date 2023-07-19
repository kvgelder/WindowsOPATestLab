# WindowsOPATestLab

![Testlab HLD](https://github.com/kvgelder/WindowsOPATestLab/blob/main/Documentation/HLD.png)

## Active Directory
### Requirements

### Setting up an Active Directory domain controller.
```PowerShell
# Input variables
$DomainName = “[FQDN]” # Change [FQDN] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSForest -DomainName $DomainName -DomainMode 7 -ForestMode 7 -InstallDns
```

### Setting up an Active Directory domain controller member.
```PowerShell
$DomainName = "[FQDN]"
$Credentials =  Get-Credential [NETBIOS NAME]\Administrator # Change [NETBIOS NAME] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSDomainController -DomainName $DomainName -InstallDns -Credential $Credentials
```

### Run Active Directory Domain Services health checks
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


## Distributed File System
### Requirements
- Require to be domain member or domain controller.
-	DFS Namespace needs to be installed on the Windows Servers that are part of the DFS (including the file storage servers).
-	DfsnRoot type DomainV2 requires Windows Server 2008 mode domain space or later.
-	File Storage servers will need a folder structure that serves as the DFS namespace.

### Setting up the folder structure on the file storage servers.
```PowerShell
# Input variables
$FolderPath = 'C:\DFS\'
$NamespaceName = 'Namespace'
$FullAccess = [NETBIOS NAME]\Administrator # Change [NETBIOS NAME] to match your environment.
$ReadAccess = 'Authenticated Users'
$HiddenShare = $True

# Background variables, don't touch unless you know what you're doing.
$FullFolderPath = $FolderPath + $NamespaceName
if ($HiddenShare) {
    $SmbShareName = $NamespaceName + '$' 
} else { 
    $SmbShareName = $NamespaceName
}
$Description = 'SMB share for ' + $NamespaceName + ' DFS namespace.'

# Create folder structure. Change folder names as necessary.
New-item -Path $FullFolderPath -Force
# Create SMB share for above folder structure
New-SmbShare -Name $SmbShareName -Description $Description -FullAccess $FullAccess -ReadAccess $ReadAccess -Path $FullFolderPath
```

### Creating the DFS Namespace root on the DFS namespace server.
Make sure the DFS namespace role is installed on all servers related to your DFS.
```PowerShell
# Input variables
$NamespaceName = 'Namespace'
$HiddenShare = $True
$TargetFolderServerName = '\\[SERVER NAME]\' # Change [SERVER NAME] to match your environment.
$Domain = '\\[FQDN]\' # Change [FQDN] to match your environment.

# Background variables, don't touch unless you know what you're doing.
if ($HiddenShare) { 
    $SmbShareName = $NamespaceName + '$' 
} else { 
    $SmbShareName = $NamespaceName
}
$TargetFolderOnServer = $TargetFolderServerName + $SmbShareName
$DFSNamespace = $Domain + $NamespaceName

# Create DfsnRoot on DFS Namespace server
New-DfsnRoot -TargetPath $TargetFolderOnServer -Type DomainV2 -Path $DFSNamespace -EnableAccessBasedEnumeration $true
```

## TODO
### Github
- [ ] Move TODO list to GitHub issues

### Active Directory
- [ ] Runbook AD: AD Object manipulation
- [ ] Runbook AD: Trusts
- [ ] AD: Modify Trusts
- [ ] Check and configure DC1 and DM1 firewall settings

### Fileshare
- [ ] Install DFS Namespaces role on DFSNS1
