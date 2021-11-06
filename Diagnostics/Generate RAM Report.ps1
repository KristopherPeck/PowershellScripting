$folderName = "Export"

#Create export directory if it doesn't already exist
if (-NOT (Test-Path -path "C:\$folderName\")) {
  New-Item -Path 'C:\' -Name "$folderName" -ItemType "directory"
}

#Use WMI to check information about installed RAM and then export it to a log file
get-wmiobject win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Speed,Partnumber,Serialnumber -autosize | Out-File (New-Item -Path "C:\$folderName\$Env:COMPUTERNAME-Memory.log" -Force)
