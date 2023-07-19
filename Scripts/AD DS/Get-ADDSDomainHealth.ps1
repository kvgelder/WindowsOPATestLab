# Shows domain controller information of the current server
Get-ADDomainController -Discover
Read-UserInputToContinue

# Active Directory services that need to be running.
Get-Service adws,kdc,netlogon,dns
Read-UserInputToContinue

# Hidden shares that mest be available. SYSVOL and NETLOGON shares.
Get-SMBshare
Read-UserInputToContinue

# Check replication between domain controllers.
Repadmin /replsummary
Read-UserInputToContinue

# Analyze the state of the domain controllers in the forest.
dcdiag
Read-UserInputToContinue

# Displays where the Flexible Single Master Operation roles are located.
Netdom /query  FSMO
Read-UserInputToContinue

function Read-UserInputToContinue {
    Write-Host -NoNewLine 'Press any key to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}