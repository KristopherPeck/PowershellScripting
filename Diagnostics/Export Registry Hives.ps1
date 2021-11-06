#Create folder if it doesn't exist
if (-NOT (Test-Path -path "C:\Export\")) {
    New-Item -Path 'C:\' -Name "Export" -ItemType "directory"
    }

#Run an export for each of the major hives except for Current User
REG Export HKLM C:\OCS\$env:COMPUTERNAME-HKLM.reg
REG Export HKU C:\OCS\$env:COMPUTERNAME-HKU.reg
REG Export HKCR C:\OCS\$env:COMPUTERNAME-HKCR.reg
