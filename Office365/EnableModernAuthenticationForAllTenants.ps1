#Establish a PowerShell session with Office 365. You'll be prompted for your Delegated Admin credentials
Connect-MsolService

Get-MsolPartnerContract | ForEach-Object {
    $tenant_id = $_.tenantid.guid
    $tenant_name = $_.name
    Get-MsolPartnerInformation -TenantId $tenant_id | Select-Object @{Expression={$tenant_name};Label="Tenant name"}
    Get-OrganizationConfig | Format-Table Oauth* -Auto
}