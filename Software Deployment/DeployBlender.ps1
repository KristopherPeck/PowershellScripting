$installDirName = "installBlender"
$installPath = "C:\Export\"
$InstallDirLocation = "$installPath\$installDirName" 
$installerName = "blender-3.2.2-windows-x64.msi" 
$destination = "$InstallDirLocation" 
$source = "https://mirror.clarkson.edu/blender/release/Blender3.2/blender-3.2.2-windows-x64.msi"
   
New-Item -Path $installPath -Name "$installDirName" -ItemType "directory" -Force
Start-BitsTransfer -Source $source -Destination $destination

Set-Location -Path $InstallDirLocation

msiexec.exe /i "$installerName" /quiet /qn ALLUSERS=1