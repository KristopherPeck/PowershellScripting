param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

$csvLocation = "$path\AllTenantEmailAddresses.csv"
$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session

$tenantIDs = Get-MsolPartnerContract -All | Select-Object TenantId

Foreach ($tenant in $tenantIDs){
    Get-MsolUser -TenantId $tenant -All | Export-Csv $csvLocation -Append
}