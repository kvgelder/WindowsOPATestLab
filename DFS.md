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
New-DfsnRoot -Path '\\[FQDN]\Namespace' -Type DomainV2 -TargetPath 'C:\DFS\Namespace' -EnableAccessBasedEnumeration $true
```

#### Namespace health checks
Check if the DfsnRoot is configured as needed using the `Get-DfsnRoot` command.
```PowerShell
# Namespace server(s)
Get-DfsnRoot -Path '\\[FQDN]\Namespace'
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
New-DfsnFolder -Path '\\[FQDN]\Namespace\Public' -TargetFolder '\\[FILE SERVER 1]\Public$' -EnableTargetFailback
New-DfsnFolderTarget -Path '\\[FQDN]\Namespace\Public' -TargetFolder '\\[FILE SERVER 2]\Public$' # To add additional file storage server(s)
```

#### DFS namespace folder health checks
Check if `New-DfsnFolder` has correctly configured by running the `Get-DfsnFolder` command.
```PowerShell
# Namespace server(s)
Get-DfsnFolder -Path '\\[FQDN]\Namespace\Public'
```

## DFS replication
### Requirements
The following needs to be configured to get DFS replication to work properly.
- DFS Replication Group
- DFS Replicated Folders
- DFS Replication Members
- DFS Replication connection
- DFS Replication Memberships

### Configuring DFS replication
Set up a DFS replication group using `New-DfsReplicationGroup`.
The DomainName parameter is optional. Leaving the DomainName blank will cause the current domain to be used.
```PowerShell
# Run on the DFS namespace server
New-DfsReplicationGroup -GroupName 'DFSR Group 1' -Description '' -DomainName '[FQDN]'
```

Next, add the folders that need to be replicated as DFS replicated folders to the replication group using `New-DfsReplicatedFolder`. 
The DomainName parameter is optional. Leaving the DomainName blank will cause the current domain to be used.
```PowerShell
# Run on the DFS namespace server
New-DfsReplicatedFolder -GroupName 'DFSR Group 1' -Description '' -FolderName 'Public' -DomainName '[FQDN]
```

Add each server that will be part of the DFS replication group as DFS replication members to the replication group using `Add-DfsrMember`.
```PowerShell
# Run on the DFS namespace server
Add-DfsrMember -GroupName 'DFSR Group 1' -Description '' -ComputerName 'Testlab-DFS1' -DomainName '[FQDN]'
Add-DfsrMember -GroupName 'DFSR Group 1' -Description '' -ComputerName 'Testlab-DFS2' -DomainName '[FQDN]'
# etc ...
```

A connection between the DFS replication group members will have to be configured by using the `Add-DfsrConnection` command.
```PowerShell
Add-DfsrConnection -GroupName 'DFS Group 1' -SourceComputerName 'Testlab-DFS1' -DestinationComputerName 'Testlab-DFS2'
```

Set up the DFS replication membership settings for the DFS replication group members via the `Set-DfsrMembership`.
In case the default staging path quota is not enough, a custom value can be set by adding the `-StagingPathQuotaInMB [integer]` parameter.
```PowerShell
Set-DfsrMembership -GroupName 'DFS Group 1' -FolderName 'Public' -ContentPath 'C:\DFS\DFSN1\Public' -ComputerName 'Testlab-DFS1' -PrimaryMember $true
Set-DfsrMembership -GroupName 'DFS Group 1' -FolderName 'Public' -ContentPath 'C:\DFS\DFSN1\Public' -ComputerName 'Testlab-DFS2' -PrimaryMember $false
```