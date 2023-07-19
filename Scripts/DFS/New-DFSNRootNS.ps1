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
New-DfsnRoot -TargetPath $TargetFolderOnServer -Type DomainV2 -Path $DFSNamespace