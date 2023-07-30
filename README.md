# WindowsOPATestLab

![Testlab HLD](Docs/HLD.png)

## Active Directory
[For detailed Active Directory configuration, see ADDS.md](ADDS.md)


## Distributed File System
[For detailed Distributed File System configuration, see DSF.md](DFS.md)

## TODO
### Scripts
- [ ] Update code the scripts files.
- [ ] Write a script that checks for the pre-reqs per MECM role. (Multiple scripts for each MECM role?)

### Active Directory
- [ ] Runbook AD: AD Object manipulation
- [ ] Runbook AD: Trusts
- [ ] AD: Modify TrustedHosts
- [ ] Check and configure DC1 and DM1 firewall settings
- [ ] AD Primary and member domain controllers trusts

### Fileshare
- [ ] Setup DFS replication for DFS Folder 'Private'
- [ ] Deploy TestLab-DFSN2

### Remote PowerShell access
- [ ] Enable WinRM HTTPS
- [ ] Configure WinRM listeners for specific devices/IP addresses only

### TrustedHosts
- [ ] IP/Device removal script will leave a comma if the first value in the list is deleted. -> Add an if statement to check for both situations.
