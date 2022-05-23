# Finder adapter
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "up"}

# Fjerner de exsisterne IP og gateways fra ipv4 adapteren.
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
    $adapter | Remove-NetIPAddress -AddressFamily "IPv4" -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
    $adapter | Remove-NetRoute -AddressFamily "IPv4" -Confirm:$false
}

# Konfigurere IP address og default gateway
$adapter | New-NetIPAddress `
-AddressFamily "IPv4" `
-IPAddress "192.168.1.4" `
-PrefixLength "24" `
-DefaultGateway "192.168.1.1"

# Konfigurere DNS klient server IP Addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses "192.168.1.2"

Install-WindowsFeature -Name RSAT-AD-PowerShell
Add-WindowsCapability –online –Name “Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0”
Add-WindowsFeature AD-Domain-Services
Import-Module ADDSDeployment
Import-Module ServerManager
Import-Module ActiveDirectory
#Add-ADDSReadOnlyDomainControllerAccount

Add-Computer -DomainName WindowsSux -Restart