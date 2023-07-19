# WindowsOPATestLab

![Testlab HLD](https://github.com/kvgelder/WindowsOPATestLab/blob/main/Documentation/HLD.png)

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
$FullAccess = WINOPATL\Administrator
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
$TargetFolderServerName = '\\Testlab-DFS1\'
$Domain = '\\WindowsOPATestlab.foots.ml\'

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
