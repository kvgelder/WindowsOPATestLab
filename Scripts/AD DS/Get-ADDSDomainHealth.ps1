function Read-UserInputToContinue {
    if ($psISE) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Press OK to continue...")
    } else {
        Write-Host -NoNewLine 'Press any key to continue...'
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    }
}

# Shows domain controller information of the current server
Write-Host "Check domain controller information."
Get-ADDomainController -Discover
Read-UserInputToContinue

# Active Directory services that need to be running.
Write-Host "Check running Active Directory services."
Get-Service adws,kdc,netlogon,dns
Read-UserInputToContinue

# Hidden shares that must be available. SYSVOL and NETLOGON shares.
Write-Host "Check if the SYSVOL and NETLOGON SMB shares are available."
Get-SMBshare
Read-UserInputToContinue

# Check replication between domain controllers.
Write-Host "Check if replication between domain controllers is working."
Repadmin /replsummary
Read-UserInputToContinue

# Analyze the state of the domain controllers in the forest.
Write-Host "Analyze the state of the domain controller in the current forest."
dcdiag
Read-UserInputToContinue

# Displays where the Flexible Single Master Operation roles are located.
Write-Host "Check where the FSMO roles are located."
Netdom /query FSMO
Read-UserInputToContinue

