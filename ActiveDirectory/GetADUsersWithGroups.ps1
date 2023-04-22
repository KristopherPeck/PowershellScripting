#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"
Import-Module Activedirectory

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

Get-ADUser -Filter * -Properties DisplayName,memberof | ForEach-Object {
  New-Object PSObject -Property @{
	UserName = $_.DisplayName
	Groups = ($_.memberof | Get-ADGroup | Select-Object -ExpandProperty Name) -join ","
	}
} | Select-Object UserName,Groups | Export-Csv "$path\$Env:COMPUTERNAME-ADUserGroupReport.csv" -NTI