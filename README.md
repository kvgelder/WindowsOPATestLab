# WindowsOPATestLab

![Testlab HLD](Docs/HLD.png)

#### Active Directory Domain Services
[For detailed Active Directory configuration, see ADDS.md](Docs/ADDS/ADDS.md)  

#### Dynamic Host Configuration Protocol
[For detailed information on Dynamic Host Configuration Protocol configuration, see DHCP.md](Docs/DHCP/DHCP.md)  

#### Distributed File System
[For detailed Distributed File System configuration, see DSF.md](Docs/DFS/DFS.md)  

#### Microsoft Endpoint Configuration Manager
[For detailed MECM configuration, see MECM.md](Docs/MECM/MECM.md)  
[For MECM pre-reqs, see MECM PREREQS.md](Docs/MECM/MECM%20PREREQS.md)  
[For a MECM standalone walkthrough, see MECM WALKTHROUGH.md](Docs/MECM/MECM%20WALKTHROUGH.md)  
[For MECM Administration, see MECM ADMINISTRATION.md](Docs/MECM/MECM%20ADMINISTRATION.md)  

#### Windows Admin Center
[Information about Windows Admin Center can be found in WAC Configuration.md](Docs/Windows%20Admin%20Center/WAC%20Configuration.md)  

## TODO
### Scripts
- [ ] Update code the scripts files.
- [ ] Write a script that checks for the pre-reqs per MECM role. (Multiple scripts for each MECM role?)
- [ ] Expand MECMClientFirewallCheck.ps1. Include firewall configuration.

### Active Directory
- [ ] Runbook AD: AD Object manipulation
- [ ] Runbook AD: Trusts
- [ ] AD: Modify TrustedHosts
- [x] Check and configure DC1 and DM1 firewall settings
- [ ] AD Primary and member domain controllers trusts

### Fileshare
- [x] Setup DFS replication for DFS Folder 'Private'
- [x] Deploy TestLab-DFSN2

### TrustedHosts
- [ ] IP/Device removal script will leave a comma if the first value in the list is deleted. -> Add an if statement to check for both situations.

### DHCP
- [ ] Check Get-DhcpServerv4Reservation command output