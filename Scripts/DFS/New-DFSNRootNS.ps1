<# 
.SYNOPSIS
    Name:   Distributed File System namespaces.

.DESCRIPTION
    Script to setup a DFS namespace on Windows Server.
    
.INPUTS
    Modify the <# Input variables> section to your settings/likings.

.OUTPUTS
    None

.NOTES
    Author:     Kevin van Gelder
    Country:    The United States of America
    Version:    1.0
    Created:    2023-07-19
    
    TODO:
        
#>

# Input variables
$NamespaceName = 'Namespace'
$HiddenShare = $True
$TargetFolderServerName = '\\Testlab-DFS1\'
$Domain = '\\WindowsOPATestlab.foots.ml\'

# Background variables, don't touch unless you know what you're doing.
if ($HiddenShare) { 
    $SmbShareName = $NamespaceName + '$' 
} else { 
    $SmbShareName = $NamespaceName
}
$TargetFolderOnServer = $TargetFolderServerName + $SmbShareName
$DFSNamespace = $Domain + $NamespaceName

# Create DfsnRoot on DFS Namespace server
New-DfsnRoot -TargetPath $TargetFolderOnServer -Type DomainV2 -Path $DFSNamespace -EnableAccessBasedEnumeration $true