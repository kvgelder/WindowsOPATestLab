# Windows Admin Center (WAC) Configuration
## General
Windows Admin Center is a locally-deployed, browser-based management tool set that lets you manage your Windows Clients, Servers, and Clusters without needing to connect to the cloud. Windows Admin Center gives you full control over all aspects of your server infrastructure and is particularly useful for managing servers on private networks that are not connected to the Internet.

Windows Admin Center is the modern evolution of "in-box" management tools, like Server Manager and MMC. It complements System Center - it's not a replacement.

## Requirements
### Operating System & software
- [ ] Local client mode: Windows 10 and Windows 11
- [ ] Gateway and Managed server, and failover cluster mode: Semi-Annual Channel, Windows Server 2022, 2019, 2016

- [ ] Windows Management Framework (WMF) 5.1 or higher is required
**WMF 5.1 Preview must be uninstalled before WMF 5.1 can be installed**
Query the `$PSVersionTable` variable in a PowerShell prompt to check which version of WMF is currently installed.

WAC communicates outbound securely over to endpoints over TCP port 443. The default route is used for internet communication.
In case outbound connectivity is restricted by a firewall or proxy server, additional configuration is required.

The following URLs are mandatory in order to use the Windows Admin Center.
### Gateway URLs
- [ ] aka.ms (Used to aquire and maintain Windows Admin Center)
- [ ] download.microsoft.com (Used to aquire and maintain Windows Admin Center)
- [ ] pkgs.dev.azure.com (Used for extension management)
- [ ] *.vsblob-vsassets.io (Used for extension management)

### Browser URLs
These URLs are used for extension management
- [ ] winadmincenterassets.blob.core.windows.net
- [ ] js.monitor.azure.com
- [ ] nuget.org
- [ ] announcements.blob.core.windows.net
- [ ] browser.events.data.microsoft.com (Used to aquire and maintain Windows Admin Center)

To manage Microsoft Hyper-V Server 2016, additional configuration is needed.
- [ ] Enable Remote Management
- [ ] Enable File Server Role
- [ ] Enable Hyper-V Module for PowerShell

## Installation
If the requirements are met, Windows Admin Center can be installed on a device in your network.