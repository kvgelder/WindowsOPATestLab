$acl = Get-Acl "C:\DFSN1\Public"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("User1","ReadAndExecute","Deny")
$acl.RemoveAccessRule($accessRule)
$acl | Set-Acl "C:\DFSN1\Public"



$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ("ENTERPRISEUser01","FullControl","Allow") $acl.RemoveAccessRule ($AccessRule)


$acesToRemove = $acl.Access | ?{ $_.IsInherited -eq $false -and $_.IdentityReference -eq 'MYCOMPUTER\myuser' }

$acl.RemoveAccessRuleAll($acesToRemove)
Set-Acl -AclObject $acl C:\myfolder\