#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"
Import-Module Activedirectory

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} -Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed", "mail" |Select-Object -Property "Displayname", "mail",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed')}} | Export-Csv -Path "$path\$Env:COMPUTERNAME-ADExpiredCreds.csv" -NoTypeInformation -Force
