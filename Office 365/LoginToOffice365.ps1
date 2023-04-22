param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

Set-PSRepository -Name PSGallery -Installationpolicy Trusted

Write-Host "Checking the ExchangeOnlineManagement Module."

if ((Get-Module -ListAvailable -Name ExchangeOnlineManagement)){
    Remove-Module ExchangeOnlineManagement -Force | Out-Null
    Update-Module -Name ExchangeOnlineManagement
} else {
    Install-Module ExchangeOnlineManagement -Force
    Import-Module ExchangeOnlineManagement -Force
}

Write-Host ""
Write-Host "Checking the MSOnline Module"
if ((Get-Module -ListAvailable -Name MSOnline)){
    Remove-Module MSOnline -Force | Out-Null
    Update-Module -Name MSOnline
} else {
    Install-Module MSOnline -Force
    Import-Module MSOnline -Force
}

Write-Host""
Write-Host "Checking the Azure AD Module"
if ((Get-Module -ListAvailable -Name AzureAD)){
    Remove-Module AzureAD -Force | Out-Null
    Update-Module -Name AzureAD
} else {
    Install-Module AzureAD -Force
    Import-Module AzureAD -Force
}

$loginLoop = $true
While ($loginLoop -eq $true){
    Write-Host "Which Module do you need to access?"
    Write-Host "1: Azure AD (Includes commands like Get-AzureADUser)"
    Write-Host "2: MSOnline (Includes commands like Get-MSolUser)"
    Write-Host "3: ExchangeOnlineManagement (Includes commmnds like Get-Mailbox)"
    Write-Host ""
    $moduleSelection = Read-Host

    While (($moduleSelection -ne "1") -and ($moduleSelection -ne "2") -and ($moduleSelection -ne "3")){
        Clear-Host
        Write-Host "Which Module do you need to Access?"
        Write-Host "1: Azure AD (Includes commands like Get-AzureADUser"
        Write-Host "2: MSOnline (Includes commands like Get-MSolUser)"
        Write-Host "3: ExchangeOnlineManagement (Includes commmnds like Get-Mailbox)"
        Write-Host ""
        $moduleSelection = Read-Host
    }

    if ($moduleSelection -eq "1"){
        Connect-AzureAD
    } elseif ($moduleSelection -eq "2") {
        Connect-MsolService
    } elseif ($moduleSelection -eq "3") {
        Connect-ExchangeOnline
    }

    Write-Host ""
    Write-Host "Do you need to connect to any other services? Y or N?"
    Write-Host ""
    $continueLoop = Read-Host

    While (($continueLoop -ne "Y") -and ($continueLoop -ne "N") -and ($continueLoop -ne "y") -and ($continueLoop -ne "n")){
        Clear-Host
        Write-Host "Do you need to connect to any other services? Y or N?"
        Write-Host ""
        $continueLoop = Read-Host 
    }

    if (($continueLoop -eq "N") -or ($continueLoop -eq "n")){
        $loginLoop = $false
    }
}