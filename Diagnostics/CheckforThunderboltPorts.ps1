$thunderboltResults = Get-pnpdevice -friendlyname '*Thunderbolt*'

if ($null -ne $thunderboltResults) {
    Write-Host ("There are Thunderbolt ports available on this system.")
}

Else {
    Write-Host ("There are not Thunderbolt ports available on this system. It likely uses USB-C")
}
