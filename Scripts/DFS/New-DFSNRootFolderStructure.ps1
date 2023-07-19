# Input variables
$FolderPath = 'C:\DFS\'
$NamespaceName = 'Namespace'
$FullAccess = WINOPATL\Administrator
$ReadAccess = 'Authenticated Users'
$HiddenShare = $True

# Background variables, don't touch unless you know what you're doing.
$FullFolderPath = $FolderPath + $NamespaceName
if ($HiddenShare) {
    $SmbShareName = $NamespaceName + '$' 
} else { 
    $SmbShareName = $NamespaceName
}
$Description = 'SMB share for ' + $NamespaceName + ' DFS namespace.'

# Create folder structure. Change folder names as necessary.
New-item -Path $FullFolderPath -Force
# Create SMB share for above folder structure
New-SmbShare -Name $SmbShareName -Description $Description -FullAccess $FullAccess -ReadAccess $ReadAccess -Path $FullFolderPath