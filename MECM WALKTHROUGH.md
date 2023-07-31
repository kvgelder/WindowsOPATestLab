    Set hostname
    Join Domain

    Create MECM AD account
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
        Managament Tools
            IIS Management Console
            IIS 6 Management Compatibility
            IIS 6 Metabase Compatibility
            IIS 6 WMI Compatibility

    Configure the firewall to allow the correct SQL ports.

```PowerShell
New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1434 -Protocol UDP -Action Allow
```
    Make sure the account you're signed in with has the correct admin permissions (Local admin in this example)
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

        - 