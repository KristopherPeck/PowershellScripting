param(
  [string]$clientID=''
  )

$licenseKey = ''
$installDirName = "installAutoElevate"
$installPath = "C:\Export\"
$InstallDirLocation = "$installPath\$installDirName" 
$installerName = "AESetup.msi" 
$destination = "$InstallDirLocation" 
$source = "https://autoelevate-installers.s3.us-east-2.amazonaws.com/current/$installerName"
   
New-Item -Path $installPath -Name "$installDirName" -ItemType "directory" -Force
Start-BitsTransfer -Source $source -Destination $destination

Set-Location -Path $InstallDirLocation

#You can create multiple entries here so you can use a single script across multiple clients. 
switch ($clientShortName)
{
    'XXX'{
        $companyName = "XXX"
        $companyInitials = "XXX"
        $locationName = "XXX"
         }

}
$MSIArguments = @(
    '/i'
    'AESetup.msi'
    '/quiet'
    "LICENSE_KEY=""$licenseKey"""
    '/lv C:\Export\installAutoElevate\AEInstallLog.log'
    "COMPANY_NAME=""$companyName"""
    "COMPANY_INITIALS=""$companyInitials"""
    "LOCATION_NAME=""$locationName"""
    "AGENT_MODE=""audit"""
)

Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow