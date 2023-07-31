Set hostname
Join Domain

Create MECM AD account
Add MECM AD account to Local Admins

Install the following roles and features
    Roles:
    - Web Server (IIS)
    - Windows Server Update Services

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