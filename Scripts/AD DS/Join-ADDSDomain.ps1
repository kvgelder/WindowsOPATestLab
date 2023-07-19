$DomainName = "[FQDN]" # Change [FQDN] to match your environment.
$Credentials =  Get-Credential [NETBIOS NAME]\Administrator # Change [NETBIOS NAME] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSDomainController -DomainName $DomainName -InstallDns -Credential $Credentials
