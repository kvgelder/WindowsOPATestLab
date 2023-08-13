# Microsoft Endpoint Configuration Manager
## General information
Microsoft Endpoint Configuration Manager (MECM), formerly System Center Configuration Center, can be used for endpoint management, software deployment, Windows update, etc.

Setting up MECM does require some preparation.

## Requirements and pre-requisites
### Operating System
The Configuration Manager site systems **must** be installed on a 64 bit OS.  
Distribution point roles could be installed on some 32 bit Operating Systems.
Windows Server Core is also not supported for site system installations.

After installing the site system server, certain configurations cannot be changed.
This includes:
- The domain name of where the site system server is located. (Domain rename)
- Domain membership of the site system server. 
- Name of the site system server.

In order to change any of these values, the site system role will first have to be removed from the server.
After the changes have been implemented, the site system role can be reinstalled.

Changes affecting the site server, first uninstall the the site server and reinstall the site server after implementing the changes.

Site systems roles cannot be installed on an instance of a Windows server cluster.

**Important**
Do not change the `start up type` or `log on as` settings for any Configuration Manager services. This might prevent key services from running / starting properly.

### Hardware requirements
#### Primary site server and database site role on same server
- 16 core CPU
- 96 GB memory
- 80% memory allocation for SQL server

It is good to keep in mind that hardware limitations such as disk I/O, network NIC speed, etc..

#### Clients
- CPU and Memory requirements that match the Operating System requirements
- 500 MB available disk space with 5 GB recommended for Configuration Manager client cache

Optional functionality will require the following minimum hardware requirements
- OS deployment: 384 MB memory
- Software Center: 500 Mhz processor
- Remote Control: at least a Hyper Threaded Pentium 4 3Ghz single core CPU + 1 GB of memory

#### Lab environment
Site and Database server
- 2-4 CPU cores
- 8-12 GB memory
- 100 GB diskspace

Clients
- 1-2 CPU cores
- 1-3 GB memory
- 30 GB disk space

### Software requirements and dependencies
#### Service account
It is possible to use a generic domain user account to install and run the MECM and associated services. Keeping security in mind, however, a more secure option is the usage of Managed Service Accounts.
These Managed Service Accounts (MSAs) can be used to identify and authenticate services; start services; access or execute code or applications; and start processes.

It is recommended to use group Managed Service Accounts (gMSAs) whenever possible. If your endpoint configurator environment will be a standalone site, however, using a standalone MSA (sMSA) would also be possible. Standalone MSAs are used on a single server, but can still be used for multiple services and processes.

#### Firewall configuration
The MECM sites and SQL server will require communication between them and the clients in order for the services to work properly.
For a basic standalone set up, a handful of ports will need to be configured to allow traffic to and from the clients and servers.

```
TCP ports:
- 135: Remote Procedure Calls
- 1433: SQL Server
- 2701,2702: Background Intelligent Transport Service
- 2703: CCMExe
- 4011: Wake on Lan
- 10123: BGB client and SMS Notification Client
- 49152-65535: Ephemeral Communication

UDP Port:
- 1433: SQL Server
```
For more detailed information see the [MECMClientFirewallCheck.ps1](Docs/Scripts/MECM/MECMClientFirewallCheck.ps1) PowerShell script.

#### Domain Name Services configuration

#### SQL Server

## MECM installation
### SQL Server


### Configuration Manager