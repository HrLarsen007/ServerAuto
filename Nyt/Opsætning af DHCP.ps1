# Installation af DHCP Service
Install-WindowsFeature DHCP -IncludeManagementTools

# Laver en DHCP security group
netsh dhcp add securitygroups

# Genstarter DHCP Service
Restart-Service dhcpserver

# Authorize the DHCP-Server
Add-DhcpServerInDC -DnsName "DC1.WindowsSux.com" -IPAddress 192.168.1.2

# Enable Dynamic DNS updates
Set-DhcpServerv4DnsSetting -ComputerName "DC1.WindowsSux.com" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

# Konfigurarer scopet
Add-DhcpServerv4Scope -name "WindowsSux" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0
Set-DhcpServerv4OptionValue -DnsDomain "WindowsSux.com" -DnsServer 192.168.1.2