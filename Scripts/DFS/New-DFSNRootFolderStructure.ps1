<# 
.SYNOPSIS
    Name:   Distributed File System SMB share setup.

.DESCRIPTION
    Script to setup a folder structure to be used for a DFS namespace on Windows Server.
    
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