# WindowsOPATestLab

![Testlab HLD](Docs/HLD.png)

## Active Directory
[For detailed Active Directory configuration, see ADDS.md](ADDS.md)


## Distributed File System
[For detailed Distributed File System configuration, see DSF.md](DFS.md)

## TODO
### Github
- [ ] Update code the scripts files.
- [ ] Update the README.md
- [ ] Restructure ADDS.md to match the DFS.md style/format.

### Active Directory
- [ ] Runbook AD: AD Object manipulation
- [ ] Runbook AD: Trusts
- [ ] AD: Modify TrustedHosts
- [ ] Check and configure DC1 and DM1 firewall settings

### Fileshare
- [x] Install DFS Namespaces role on DFSNS1
- [x] Install TestLab-DFS1 and TestLab-DFS2 File Server
- [x] Create file structures on TestLab-DFS1 and TestLab-DFS2
- [x] Create SMB shares on TestLab-DFS1 and TestLab-DFS2
- [x] Create DFS namespace root on TestLab-DFSN1
- [ ] Setup DFS replication for DFS Folder 'Private'
- [ ] Deploy TestLab-DFSN2