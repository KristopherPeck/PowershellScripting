#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

$thunderboltResults = Get-pnpdevice -friendlyname '*Thunderbolt*'

if ($null -ne $thunderboltResults) {
    $thunderboltResults | Out-File "$path\$env:computername-ThunderboltResults.log"
    Write-Host ("There are Thunderbolt ports available on this system.")
}

Else {
    $thunderboltResults | Out-File "$path\$env:computername-ThunderboltResults.log"
    Write-Host ("There are not Thunderbolt ports available on this system. It likely uses USB-C")
}
