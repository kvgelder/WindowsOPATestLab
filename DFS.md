# Distributed File System

## Domain based DFS
### Requirements
- Require to be domain member or domain controller.
- DFS Namespace needs to be installed on the Windows Servers that are part of the DFS (including the file storage servers).
- DfsnRoot type DomainV2 requires Windows Server 2008 mode domain space or later.
- File Storage servers will need a folder structure that serves as the DFS namespace.

### Setting up a namespace
Create the folder structure on the DFS Namespace server.
```PowerShell
# Namespace server(s)
New-Item -Path 'C:\DFS\Namespace' -Type Directory
```
Setup the DFSN Root for the newly created Namespace folder.
```PowerShell
# Namespace server(s)
New-DfsnRoot -Path '\\[DOMAIN NAME]\Namespace' -Type DomainV2 -TargetPath 'C:\DFS\Namespace' -EnableAccessBasedEnumeration $true
```

#### Namespace health checks
Check if the DfsnRoot is configured as needed using the `Get-DfsnRoot` command.
```PowerShell
# Namespace server(s)
Get-DfsnRoot -Path '\\[DOMAIN NAME]\Namespace'
```

### Setting up the file structure
On each file storage servers create the folder(s) which will function as the DFS storage share.
And set up the SMB share(s) for each of the folder(s).
```PowerShell
# File storage server(s)
New-Item -Path 'C:\DFS\Namespace\Public' -Type Directory
New-SmbShare -Name 'Public$' -Description 'Public DFS share' -Path 'C:\DFS\Namespace\Public' -FullAccess 'WINOPATL\Administrator' -ChangeAccess 'Domain Users' -ReadAccess 'Authenticated Users'
```

### Adding FolderTargets to the DFS namespace
On the DFS namespace server, set up DFS namespace folders for each file storage server that will be part of the DFS namespace.
```PowerShell
# Namespace server(s)
New-DfsnFolder -Path '\\[DOMAIN NAME]\Namespace\Public' -TargetFolder '\\[FILE SERVER 1]\Public$' -EnableTargetFailback
New-DfsnFolderTarget -Path '\\[DOMAIN NAME]\Namespace\Public' -TargetFolder '\\[FILE SERVER 2]\Public$' # To add additional file storage server(s)
```

#### DFS namespace folder health checks
Check if `New-DfsnFolder` has correctly configured by running the `Get-DfsnFolder` command.
```PowerShell
# Namespace server(s)
Get-DfsnFolder -Path '\\[DOMAIN NAME]\Namespace\Public'
```

### [Optional] Enabling DFS replication