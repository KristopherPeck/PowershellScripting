Import-Module ActiveDirectory

$Users = (Get-ADUser -Filter {Enabled -eq $false})

foreach ($user in $Users){
    $userAccountName = $user.SamAccountName
    Set-adUser $userAccountName -Add @{msExchHideFromAddressLists="TRUE"}
}