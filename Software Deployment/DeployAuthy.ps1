#path to download locally
$installDirName = "installAuthy"
$installPath = "C:\Export\"
$InstallDirLocation = "$installPath\$installDirName" 
$installerName = "Authy.exe" 
$destination = "$InstallDirLocation" 
   
New-Item -Path $installPath -Name "$installDirName" -ItemType "directory" -Force

if ([System.Environment]::Is64BitOperatingSystem -eq $True){
    $source = "https://electron.authy.com/download?channel=stable&arch=x64&platform=win32&version=latest&product=authy"
}

else {
    $source = "https://electron.authy.com/download?channel=stable&arch=x32&platform=win32&version=latest&product=authy"
}

Invoke-WebRequest -uri $source -OutFile $destination\$installerName

# Start the installation
Set-Location -Path $InstallDirLocation
& 'Authy.exe' /s
