# WindowsOPATestLab

![Testlab HLD](Docs/HLD.png)

#### Active Directory Domain Services
[For detailed Active Directory configuration, see ADDS.md](Docs/ADDS/ADDS.md)  

#### Distributed File System
[For detailed Distributed File System configuration, see DSF.md](Docs/DFS/DFS.md)  

#### Microsoft Endpoint Configuration Manager
[For detailed MECM configuration, see MECM.md](Docs/MECM/MECM.md)  
[For MECM pre-reqs, see MECM PREREQS.md](Docs/MECM/MECM%20PREREQS.md)  
[For a MECM standalone walkthrough, see MECM WALKTHROUGH.md](Docs/MECM/MECM%20WALKTHROUGH.md)  
[For MECM Administration, see MECM ADMINISTRATION.md](Docs/MECM/MECM%20ADMINISTRATION.md)  


## TODO
### Scripts
- [ ] Update code the scripts files.
- [ ] Write a script that checks for the pre-reqs per MECM role. (Multiple scripts for each MECM role?)
- [ ] Expand MECMClientFirewallCheck.ps1. Include firewall configuration.

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

