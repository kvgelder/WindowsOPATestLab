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
New-Item -Path 'C:\DFS\Namespace' -Type Directory
```
Setup the DFSN Root for the newly created Namespace folder.
```PowerShell
New-DfsnRoot -Path '\\WindowsOPAtestLab.foots.ml\Namespace' -Type DomainV2 -TargetPath 'C:\DFS\Namespace' -EnableAccessBasedEnumeration $true
```

#### Namespace health checks
Check if the DfsnRoot is configured as needed using the `Get-DfsnRoot` command.
```PowerShell
Get-DfsnRoot -Path '\\WindowsOPAtestlab.foots.ml\Namespace'
```

### Setting up the file structure
On each file storage servers create the folder(s) which will function as the DFS storage share.
And set up the SMB share(s) for each of the folder(s).
```PowerShell
New-Item -Path 'C:\DFS\Namespace\Public' -Type Directory

New-SmbShare -Name 'Public$' -Description 'SMB share for the Public DFS folder.' -Path 'C:\DFS\Namespace\Public' -FullAccess 'WINOPATL\Administrator' -ChangeAccess 'Domain Users' -ReadAccess 'Authenticated Users'
```
On the DFS namespace server, set up DFS namespace folders for each file storage server that will be part of the DFS namespace.
```PowerShell
New-DfsnFolder -Path '\\WindowsOPAtestlab.foots.ml\Namespace\Public' -TargetFolder '\\Testlab-DFS1\Public$' -EnableTargetFailback
```

### Adding FolderTargets to the DFS namespace


### [Optional] Enabling DFS replication