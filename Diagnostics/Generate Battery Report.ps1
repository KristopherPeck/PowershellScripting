#Set our path to where we want the files to be stored. 
$path = "C:\Export"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

#Uses powercfg to generate a Battery Report to see an overall health view of the battery. 
powercfg /batteryreport /output "$path\$Env:COMPUTERNAME-BatteryReport.html"
