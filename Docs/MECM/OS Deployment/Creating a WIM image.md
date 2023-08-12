```PowerShell
$SourceImagePath = "C:\Win10Source\"
$SourceImageName = "install.esd"
$DestinationImagePath = "C:\Win10Destination\"
$DestinationImageName = "win10.wim"

$SourceImage = $SourceImagePath + $SourceImageName
$DestinationImage = $DestinationImagePath + $DestinationImageName

# Display Source Indices of the SourceImage
Get-WindowsImage -ImagePath $ImagePath

do {
    $SourceIndex = Read-Host "Select source index integer"
} until ($SourceIndex -gt 0)

New-WindowsImage -CapturePath $SourceImage -ImagePath $DestinationImage
```