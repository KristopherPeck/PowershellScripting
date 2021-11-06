#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

#Use WMI to check information about installed RAM and then export it to a log file
get-wmiobject win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Speed,Partnumber,Serialnumber -autosize | Out-File (New-Item -Path "$path\$Env:COMPUTERNAME-Memory.log" -Force)
