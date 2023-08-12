Basic Configuration
    Set hostname
    Join Domain

    Create MECM AD account ### (standalone) Managed Service Account -> New-ADServiceAccount
    Add MECM AD account to Local Admins

Install the following roles and features  

    Roles:  
    - Web Server (IIS)  
    - Windows Server Update Services <################> Has been causing issues Can't seem to install. "Features or Roles require a restart"  

    Features:
    - .NET Framework 3.5 features
        - .NET Framework 3.5 HTTP Activation
        Includes:
        - Web Server Application Development .NET Extensibility 3.5
        - Windows Process Activation Service .NET Environment 3.5
    - .NET Framework 4.8 Features
        - ASP.NET4.8
        - HTTP Activation
    - Background Intelligent Transfer Services (BITS)
        - BITS server Extensions Tools
        - Common HTTP features
            - Directory Browsing
            - HTTP Errors
            - HTTP Redirection
        - Health and Diagnostics
            - HTTP Logging
            - Tracing
            - Logging Tools
            - Request Monitor
        - Performance
            - Static Content Compression
        - IIS Management Console
    - Remote Differential Compression

    WSUS Role Services  <############################> Can't seem to install. "Features or Roles require a restart"
        WID Connectivity
        WSUS Services
    
    IIS Role Services
        Common HTTP Features
            Default Document
            Directory Browsing
            HTTP Errors
            Static Content
            HTTP Redirection
        Health and Diagnostics
            HTTP Logging
            Logging Tools
            Request Monitor
            Tracing
        Performance
            Static Content Compression
            Dynamic Content Compression
        Security
            Request Filtering
            Windows Authentication
        Application Development
            .NET Extensibility 3.5
            .NET Extensibility 4.8
            ASP.NET 3.5
            ASP.NET 4.8
            ISAPI Extensions
            ISAPI Filters
        Management Tools
            IIS Management Console
            IIS 6 Management Compatibility
            IIS 6 Metabase Compatibility
            IIS 6 WMI Compatibility

Automatically start the BITS service.  
    - Open the services manager  
    - Right click the BITS service and select properties.  
    - Set startup type to Automatic delayed

Make sure the account you're signed in with has the correct admin permissions (Domain admin assigned local admin rights in this example).

Start the SQL installer  
    - Run the System Configuration Checker  
    - Start the installation of a standalone server  
    - Select the Database Engine Services feature  
    - Set your Instance Root directory, Shared feature directory, and Shared Feature directory x86  
    - Instance can be either a named or default instance, use a dedicated instance for each site though.  
    - Specified SAMECM1 (Normal AD User) account as SQL Agent and Database Account  
    Default specified accounts: `NT Service\SQLAgent$MECMMSSQLSERVER` and `NT Service\MSSQL$MECMMSSQLSERVER`  
  
    - Select authentication (Windows Authentication)  
    - Specify SQL Server Admin  
    - Leave the other settings default  
  
    - Enable 'Named Pipes' for the SQL Server via the SQL Server Configuration Manager.  
    - Configure a static TCP port that will be used using the SQL Configuration Manager.  
        - Open SQL Server Configuration Manager  
        - Open the SQL Server Network Configuration  
        - Select 'Protocols for [instance name].  
        - Right click TCP/IP and click on properties.  
        - On the IP Addresses tab, set TCP Dynamic ports to 0, and specify a static port. (Either for all IP#, or just IPAll)  


Configure the firewall to allow the correct SQL ports.

```PowerShell
New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1433 -Protocol UDP -Action Allow
```

Install Windows ADK  
    Features:  
    - Deployment Tools  
    - ICD  
    - Configuration Designer  
    - USMT  
    - Windows Performance Toolkit  

Install the Windows PE Addon for ADK. The Preinstallation Environment components are not included in the ADK installer anymore.

Extend the Active Directory Schema using the 'SMSSETUP\BIN\X64\extadsch.exe' executable.  
*To extend the AD Schema, you will need 'Schema Admin' permissions*

We also have to make sure the System Management Active Directory container exists, and our server/account has the correct permissions assigned to this container.  
    - Open adsiedit.msc  
    - Open the default naming context  
    - Open the CN=System container  
    - Right click the CN=System container  
    - Create new object of type container with the name 'System Management'  
    - Right click on the newly created 'System Management' container and select 'properties'.  
    - Go to the 'Security' tab.  
    - Click 'Advanced'  
    - Click 'Add' and add the device, or the account that is used to install all pre requisites and MECM.  
    - Check 'Full control' in the Permissions section.  

Start the MECM installation  
    - Install a Configuration Manager primary site  
    - Depending on whether you have modified certain settings (such as the SQL Server Instance name, you may want to go through the full MECM installation setup yourself, and uncheck the "Use typical installation options for a stand-alone primary site' box.)  
    - Check the 'Use typical installation options for a stand-alone primary site' box.  
        This will configure and install the following:  
            - Install a Configuration Manager primary site  
            - Use default installation path  
            - Configure local SQL server with default settings  
            - Enable a local management point for Configuration Manager  
            - Enable a local distribution point for Configuration Manager  

    - Enter a valid license key  
    - Accept the License terms and click next  
        *In case there seem to be issues with the prerequisite downloads, make sure your DNS server is configured properly*  
    - Specify a 'Site code'. Beware of the following reserved site codes: AUX, CON, NUL, PRN, SMS, ENV.  
    - Specify a site name.  
    - Select the MECM installation folder.  
    - Check the 'Install the Configuration Manager console' if you want to manage the Configuration Manager site from the device on which MECM will be installed.  

    If you are configuring the settings manually follow the next section, otherwise you can skip to the review section  
    - Check the 'Install the primary site as a stand-alone site' option.  
    - Enter the SQL Server FQDN  
    - Enter the instance name that you supplied during the SQL Server installation.  
    - If you haven't already, create a new database in your SQL Server instance matching the following naming convention 'CM_[Sitecode]'.  
    - Set the paths to the SQL Server data file and log file.  
    - Specify the FQDN of the server that will act as SMS provider (could be the stand-alone server).  
    - Select 'Configure the communication method on each site system role'.  
    - Check 'Clients will use HTTPS when they have a valid PKI certificate and HTTPS-enabled site roles are available'. This will allow you to use HTTP in case you do not want to set up a PKI infrastructure.  
    - Select HTTP/HTTPS as the client connection you want to use.  
    - Check 'Yes, let's get connected' and enter the FQDN for the server that will be used as the service connection point. (The device on which MECM will be installed.)  

    - Review all selected component settings.  
    - The installer will complete the pre requisite check at this stage. If there are any issues, these will be listed and have to be resolved before you can continue.  







Access right to AD Container 'System Management'#######################################################

Log on as a domain administrator.
Launch ADSI Edit (adsiedit.msc).
Open the domain partition, expand the domain name, and right-click the CN=System container. Select New then Object in the context menu.
Select the container type, enter a name of System Management, and press Next then Finish.
Now you need to give the SCCM server full permissions on the System Management container and its child objects.

Still within ADSI Edit, right-click the System Management container and select Properties.
Select the Security tab.
Click Add, select the computer account of the SCCM server, and grant it Full Control.






###########################
Warnings

WSUS on site server

Verify site server permissions to pulbish to Active Directory

Windows Server 2012 and 2012 R2 lifecycle

SQL Server security mode