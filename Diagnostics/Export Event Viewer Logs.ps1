#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"
#Gets the name of each event viewer folder possible from NTEventLogFile
$eventViewerFolders = Get-WmiObject Win32_NTEventlogFile | Select-Object -ExpandProperty logfilename

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

#Iterate through each entry and create an exported file with the computer name and date so they are distinct. Saves them to the path we made earlier. 
foreach ($entry in $eventViewerFolders) {
      $exportFileName = $entry + "-$Env:COMPUTERNAME-" + (get-date -f dd-MM-yyyy) + ".evt"
      $logFile = Get-WmiObject Win32_NTEventlogFile | Where-Object {$_.logfilename -eq $entry}
      $logFile.backupeventlog($path + $exportFileName)
}
