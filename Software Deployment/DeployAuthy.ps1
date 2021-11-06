#path to download locally
$installDirName = "installAuthy"
$installPath = "C:\Export\"
$InstallDirLocation = "$installPath\$installDirName" 
# Download the installer from the website. Check URL because it can be changed for new versions
$installerName = "Authy.exe" 

if ([System.Environment]::Is64BitOperatingSystem -eq $True){
    $source = "https://electron.authy.com/download?channel=stable&arch=x64&platform=win32&version=latest&product=authy"
}

else {
    $source = "https://electron.authy.com/download?channel=stable&arch=x32&platform=win32&version=latest&product=authy"
}
$destination = "$InstallDirLocation" 
   
New-Item -Path 'C:\OCS\AppDeploy\' -Name "$installDirName" -ItemType "directory" -Force

Invoke-WebRequest -uri $source -OutFile $destination\$installerName

# Start the installation
Set-Location -Path $InstallDirLocation
& 'Authy.exe' /s