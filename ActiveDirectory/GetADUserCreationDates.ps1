#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

Import-Module Activedirectory
Get-ADUser -Filter * -Property whenCreated | Select-Object Name,whenCreated | Export-Csv -path "$path\$env:computername-ADUserCreation.csv"