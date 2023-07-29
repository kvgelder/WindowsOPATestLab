Microsoft Endpoint Configuration Manager pre-requisites for a lab environment

- [ ] Windows Server 64 bit
- [ ] 2-4 CPU cores
- [ ] 8-12 GB memory
- [ ] 100 GB disk space

# Site Server
- [ ] Server is domain joined
- [ ] Server device name has been configured
- [ ] .NET version 4.8 is installed (version 4.6.2 minimum).
- [ ] Windows Assessment and Deployment Kit (ADK) must be installed.
- [ ] Microsoft Visual C++ 2015-2019 redistributable  is installed automatically starting in version 2107.

# SQL Server Native Client
- [ ] SQL Server Native Client will be automatically installed when a new site is installed. Upgrades are not done by the Configuration Manager installation. [SQL Server Native Client Pre reqs](https://learn.microsoft.com/en-us/mem/configmgr/core/servers/deploy/install/list-of-prerequisite-checks#sql-server-native-client)

# SQL Server
- [ ] Enable the **Remote Registry service** during the installation of the Configuration Manager site.
- [ ] Install [a supported version](https://learn.microsoft.com/en-us/mem/configmgr/core/plan-design/configs/support-for-sql-server-versions) of SQL Server to host the site database.
- [ ] SQL Server Native Client is installaed for the site database server. 

# SMS Provider
- [ ] The SMS Provider server requires an installation of Windows ADK.
- [ ] The SMS provider will install the IIS server role.
- [ ] SMS provider requires .NET 4.6.2 or later. Version 4.8 is recommended.
- [ ] SQL Server Native client for the SMS provider is automatically installed.

# Distribution Point
- [ ] Background Intelligent Transfer Service (BITS) is used for content transfer. The BITS IIS Server Extension is not required.
- [ ] IIS Application Development + ISAPI Extensions
- [ ] Windows Authentication role for increased security.
- [ ] IIS 6 compatibility -> IIS 6 Metabase and IIS 6 WMI.
- [ ] IIS needs permissions to use the GET, HEAD, and PROPFIND HTTP verbs.
- [ ] Configuration Manager will install Microsoft Visual C++ 2015-2019 redistributable on each server that hosts a distribution point.
To enable PXE support there are 2 options.
- [ ] Enable the Configuration Manager PXE responder, or
- [ ] Install and configure the Windows Deployment Services role
- [ ] 
- [ ] 
- [ ] 