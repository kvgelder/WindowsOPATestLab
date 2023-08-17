# Input variables
$DomainName = “[FQDN]” # Change [FQDN] to match your environment.

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose
Install-ADDSForest -DomainName $DomainName -DomainMode 7 -ForestMode 7 -InstallDns
