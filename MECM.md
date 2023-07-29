# Microsoft Endpoint Configuration Manager
## General information
Microsoft Endpoint Configuration Manager (MECM), formerly System Center Configuration Center, can be used for endpoint management, software deployment, Windows update, etc.

Setting up MECM does require some preparation

## Requirements and pre-requisites
- Operating System
    Each site system must be installed on a 64 bit OS
    The distribution points could be installed on some 32 bit Operating Systems.

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
#### SQL Server

## Service account


## Firewall configuration


## Domain Name Services configuration


## MECM installation
### SQL Server


### Configuration Manager