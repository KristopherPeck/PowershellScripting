#Establish a PowerShell session with Office 365. You'll be prompted for your Delegated Admin credentials
Connect-MsolService
$customers = Get-MsolPartnerContract -All
Write-Host "Found $($customers.Count) customers for $((Get-MsolCompanyInformation).displayname)." -ForegroundColor DarkGreen
#Set the Path to where we want the exports to be stored.
$path = "C:\Export\"

#Check if the folder exists and create it if it does not.
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}
  
foreach ($customer in $customers) {
    Write-Host "Retrieving license info for $($customer.name)" -ForegroundColor Green
    $licensedUsers = Get-MsolUser -TenantId $customer.TenantId -All | Where-Object {$_.islicensed}
  
    foreach ($user in $licensedUsers) {
        Write-Host "$($user.displayname)" -ForegroundColor Yellow  
        $licenses = $user.Licenses
        $licenseArray = $licenses | foreach-Object {$_.AccountSkuId}
        $licenseString = $licenseArray -join ", "
        Write-Host "$($user.displayname) has $licenseString" -ForegroundColor Blue
        $licensedSharedMailboxProperties = [pscustomobject][ordered]@{
            CustomerName      = $customer.Name
            DisplayName       = $user.DisplayName
            Licenses          = $licenseString
            TenantId          = $customer.TenantId
            UserPrincipalName = $user.UserPrincipalName
        }
        $licensedSharedMailboxProperties | Export-CSV -Path "$path\AllTenantLicensing.csv" -Append -NoTypeInformation   
    }
}