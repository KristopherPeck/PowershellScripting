#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

#Run an export for each of the major hives except for Current User. It will overwrite any existing exports that were done. 
Write-Host "Exporting HKLM"
REG Export HKLM $path\$env:COMPUTERNAME-HKLM.reg /y
Write-Host "Exporting HKU"
REG Export HKU $path\$env:COMPUTERNAME-HKU.reg /y
Write-Host "Exporting HKCR"
REG Export HKCR $path\$env:COMPUTERNAME-HKCR.reg /y
