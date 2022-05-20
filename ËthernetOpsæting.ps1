#Sætter variabler
$IPType = Read-Host "Enter IPType (IPv4 or IPv6)"
$IP = Read-Host "Enter IP address (192.168.1.1 example)"
$Cider = Read-Host "Enter MASKBits/Cider"
$Gateway = Read-Host "Enter gateway (192.168.1.1 example)"
$Dns = Read-Host "Enter DNS (8.8.8.8 example)"
$DomainName = Read-Host "Enter Domain Name (windowsSux example)"

# Finder adapter
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "up"}

# Fjerner de exsisterne IP og gateways fra ipv4 adapteren.
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
    $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
   }
   If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
    $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
   }

# Konfigurere IP address og default gateway
$adapter | New-NetIPAddress `
-AddressFamily $IPType `
-IPAddress $IP `
-PrefixLength $Cider `
-DefaultGateway $Gateway

# Konfigurere DNS klient server IP Addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $Dns

# Tilføjer computeren ind i et domain og genstarter.
Add-Computer -DomainName $DomainName -Restart