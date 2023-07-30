Microsoft Endpoint Configuration Manager pre-requisites for a lab environment

# Table of Contents
- [Single server MECM lab requirements](https://github.com/kvgelder/WindowsOPATestLab/blob/main/MECM%20PREREQS.md#single-server-mecm-environment)

# General Overview
- [ ] Windows Server Desktop Experience 64 bit
- [ ] 2-4 CPU cores
- [ ] 8-12 GB memory
- [ ] 100 GB disk space

## Active Directory
- [ ] Service Account is created specifically for MECM and SQL Server

## Site Server
- [ ] Server is domain joined
- [ ] Server device name has been configured
- [ ] .NET version 4.8 is installed (version 4.6.2 minimum).
- [ ] Windows Assessment and Deployment Kit (ADK) must be installed.
- [ ] Microsoft Visual C++ 2015-2019 redistributable  is installed automatically starting in version 2107.

## SQL Server Native Client
- [ ] SQL Server Native Client will be automatically installed when a new site is installed. Upgrades are not done by the Configuration Manager installation. [SQL Server Native Client Pre reqs](https://learn.microsoft.com/en-us/mem/configmgr/core/servers/deploy/install/list-of-prerequisite-checks#sql-server-native-client)

## SQL Server
- [ ] Enable the **Remote Registry service** during the installation of the Configuration Manager site.
- [ ] Install [a supported version](https://learn.microsoft.com/en-us/mem/configmgr/core/plan-design/configs/support-for-sql-server-versions) of SQL Server to host the site database.
- [ ] SQL Server Native Client is installed for the site database server. 

## SMS Provider
- [ ] The SMS Provider server requires an installation of Windows ADK.
- [ ] The SMS provider will install the IIS server role.
- [ ] SMS provider requires .NET 4.6.2 or later. Version 4.8 is recommended.
- [ ] SQL Server Native client for the SMS provider is automatically installed.

## Distribution Point
- [ ] Background Intelligent Transfer Service (BITS) is used for content transfer. The BITS IIS Server Extension is not required.
- [ ] IIS Application Development + ISAPI Extensions
- [ ] Windows Authentication role for increased security.
- [ ] IIS 6 compatibility -> IIS 6 Metabase and IIS 6 WMI.
- [ ] IIS needs permissions to use the GET, HEAD, and PROPFIND HTTP verbs.
- [ ] Configuration Manager will install Microsoft Visual C++ 2015-2019 redistributable on each server that hosts a distribution point.
To enable PXE support there are 2 options.
- [ ] Enable the Configuration Manager PXE responder, or
- [ ] Install and configure the Windows Deployment Services role
WDS is automatically installed and configured when PXE support is enabled on a distribution point.  
- [ ] Multicast support requires the WDS role to be installed.

## Endpoint Protection Point
- [ ] .NET Framework 3.5 is required
- [ ] Windows Defender features (Windows Server 2016 or later).

## Management Point
This role is automatically installed on a new primary or secondary site.
- [ ] Enable BITS Server Extensions + auto selected options, or
- [ ] BITS + auto selected options
- [ ] IIS Applications development ISAPI extensions
- [ ] Windows Authentication role for increased security
- [ ] IIS 6 Management Compatibility + IIS 6 Metabase + IIS 6 WMI
- [ ] IIS needs permission for the following HTTP verbs: GET, POST, CCM_POST, HEAD, PROPFIND
- [ ] [A supported version](https://learn.microsoft.com/en-us/mem/configmgr/core/plan-design/configs/site-and-site-system-prerequisites#net-version-requirements) of .NET
- [ ] SQL Server Native Client is automaticall installed when a new site is installed with the Configuration Manager.

## Software update point
- [ ] Windows Server Update Services server is required
- [ ] .NET framework 3.5
- [ ] Default IIS configuration is required
- [ ] WSUS role is required on the Software Update Point.
When the Software Update Point is installed on a remote site system, install the WSUS administration console on the site server.
- [ ] SQL Native Client is automatically installed when a new site is installed with the Configuration Manager.

## State Migration Point
- [ ] .NET Framework 3.5
- [ ] HTTP Activation (auto selected option)
- [ ] ASP.NET 4.5
- [ ] IIS Common HTTP features - Default document
- [ ] Application Development ASP.NET 3.5; .NET Extensibilty 3.5; ASP.NET 4.5 (auto selected option); .NET Extensibility 4.5
- [ ] IIS 6 Management compatibility + IIS 6 Metabase


# Single Server MECM environment
- [ ] Windows Server Desktop Experience 64 bit
- [ ] 2-4 CPU cores
- [ ] 8-12 GB memory
- [ ] 100 GB disk space

- [ ] Service Account is created specifically for MECM and SQL Server

- [ ] Server is domain joined
- [ ] Server device name has been configured
- [ ] .NET version 4.8 is installed (version 4.6.2 minimum).
- [ ] Windows Feature .NET Framework 3.5 is enabled
- [ ] Windows Assessment and Deployment Kit (ADK) must be installed.
- [ ] Microsoft Visual C++ 2015-2019 redistributable  is installed automatically starting in version 2107.
- [ ] Windows Server Update Services role and features enabled
- [ ] Remote Differential Compression role and features enabled

- [ ] SQL Server 2022 is installed (MECM Current Branch 2303+)
- [ ] Default or named instance of SQL Server
- [ ] Register the Service Principal Name (SPN) for the service account to run the SQL Server service

- [ ] BITS Server Role + auto selected options enabeld

- [ ] IIS Server role + Applications development ISAPI extensions enabled
- [ ] IIS 6 Management Compatibility + IIS 6 Metabase + IIS 6 WMI enabled
- [ ] IIS needs permission for the following HTTP verbs: GET, POST, CCM_POST, HEAD, PROPFIND
- [ ] Default IIS configuration is required for the Software Update Point role

- [ ] Windows Defender features are enabled (for the Endpoint Protection Point role)

The following are required for the State Migration Point role
- [ ] HTTP Activation (auto selected option)
- [ ] ASP.NET 4.5
- [ ] IIS Common HTTP features - Default document
- [ ] Application Development ASP.NET 3.5; .NET Extensibilty 3.5; ASP.NET 4.5 (auto selected option); .NET Extensibility 4.5
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 

- [ ] SMS Provider Role <- used to access and modify Configuration Manager data



[Site prerequisites](https://learn.microsoft.com/en-us/mem/configmgr/core/plan-design/configs/site-and-site-system-prerequisites)