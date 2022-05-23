
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
-IPAddress "192.168.1.3" `
-PrefixLength "24" `
-DefaultGateway "192.168.1.1"

$adapter | Set-DnsClientServerAddress -ServerAddresses $Dns

# Tilføjer computeren ind i et domain og genstarter.
Add-Computer -DomainName $DomainName -Restart

# Installtion af File-Services
Install-WindowsFeature File-Services

# Laver folders til at share
md C:\File1\Salg
md C:\File1\HR
md C:\File1\IT

# Opretter Shares til vores folders
New-SmbShare -Name IT -Path C:\File1\IT  -FullAccess Everyone
New-SmbShare -Name HR -Path C:\File1\HR -FullAccess Everyone
New-SmbShare -Name Salg -Path C:\File1\Salg -FullAccess Everyone 


$aclShare_IT_Read = Get-Acl C:\File1\IT
$AccessRuleShare_IT_Read = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\IT_Share_File1_RA","Read","Allow")
$aclShare_IT_Read.SetAccessRule($AccessRuleShare_IT_Read)
$aclShare_IT_Read | Set_Acl C:\File1\IT

$aclShare_IT_Full = Get-Acl C:\File1\IT
$AccessRuleShare_IT_Full = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\IT_Share_File1_FA","Full","Allow")
$aclShare_IT_Full.SetAccessRule($AccessRuleShare_IT_Full)
$aclShare_IT_Full | Set_Acl C:\File1\IT

$aclShare_IT_Modify = Get-Acl C:\File1\IT
$AccessRuleShare_IT_Modify = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\IT_Share_File1_CA","Modify","Allow")
$aclShare_IT_Modify.SetAccessRule($AccessRuleShare_IT_Modify)
$aclShare_IT_Modify | Set_Acl C:\File1\IT


$aclShare_HR_Read = Get-Acl C:\File1\HR
$AccessRuleShare_HR_Read = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\HR_Share_File1_RA","Read","Allow")
$aclShare_HR_Read.SetAccessRule($AccessRuleShare_HR_Read)
$aclShare_HR_Read | Set_Acl C:\File1\HR

$aclShare_HR_Full = Get-Acl C:\File1\HR
$AccessRuleShare_HR_Full = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\HR_Share_File1_FA","Full","Allow")
$aclShare_HR_Full.SetAccessRule($AccessRuleShare_HR_Full)
$aclShare_HR_Full | Set_Acl C:\File1\HR

$aclShare_HR_Modify = Get-Acl C:\File1\HR
$AccessRuleShare_HR_Modify = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\HR_Share_File1_CA","Modify","Allow")
$aclShare_HR_Modify.SetAccessRule($AccessRuleShare_HR_Modify)
$aclShare_HR_Modify | Set_Acl C:\File1\HR

$aclShare_Salg_Read = Get-Acl C:\File1\Salg
$AccessRuleShare_Salg_Read = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\Salg_Share_File1_RA","Read","Allow")
$aclShare_Salg_Read.SetAccessRule($AccessRuleShare_Salg_Read)
$aclShare_Salg_Read | Set_Acl C:\File1\Salg

$aclShare_Salg_Full = Get-Acl C:\File1\Salg
$AccessRuleShare_Salg_Full = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\Salg_Share_File1_FA","Full","Allow")
$aclShare_Salg_Full.SetAccessRule($AccessRuleShare_Salg_Full)
$aclShare_Salg_Full | Set_Acl C:\File1\Salg

$aclShare_Salg_Modify = Get-Acl C:\File1\Salg
$AccessRuleShare_Salg_Modify = New-Object System.Security.AccessControl.FileSystemAccessRule("WindowsSux.com\Salg_Share_File1_CA","Modify","Allow")
$aclShare_Salg_Modify.SetAccessRule($AccessRuleShare_Salg_Modify)
$aclShare_Salg_Modify | Set_Acl C:\File1\Salg


