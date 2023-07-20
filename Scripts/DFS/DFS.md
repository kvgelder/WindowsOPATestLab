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

### Setting up the file structure


### Adding FolderTargets to the DFS namespace


### [Optional] Enabling DFS replication