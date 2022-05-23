
workflow ADDCOpsætning{
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
    -IPAddress "192.168.1.2" `
    -PrefixLength "24" `
    -DefaultGateway "192.168.1.1"
    
    # Konfigurere DNS klient server IP Addresses
    $adapter | Set-DnsClientServerAddress -ServerAddresses "192.168.1.2"
    
    
    Add-WindowsFeature AD-Domain-Services
    Import-Module ADDSDeployment
    Import-Module ServerManager
    Import-Module ActiveDirectory
    Install-WindowsFeature -Name RSAT-AD-PowerShell
    Add-WindowsCapability –online –Name “Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0”
    Install-ADDSForest -DomainName "WindowsSux.com" -InstallDNS
    BrugerOpsætning

}

workflow BrugerOpsætning {
    New-ADUser -Name "Dorte" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity HR -Members Dorte
    New-ADUser -Name "Lis" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity HR -Members Lis
    New-ADUser -Name "Billy" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity IT -Members Billy
    New-ADUser -Name "Bob" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity IT -Members Bob
    New-ADUser -Name "Sjakal1" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity Salg -Members Sjakal1
    New-ADUser -Name "Sjakal2" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC=WindowsSux, DC=COM" -Enabled $true
    Add-ADGroupMember -Identity Salg -Members Sjakal2
    GrupperOpsætning
}

workflow GrupperOpsætning {
    New-ADOrganizationalUnit -Name "BrugerAccounts" -Path "DC=WindowsSux,DC=COM"
    New-ADGroup -Name "IT" -GroupScope DomainLocal
    New-ADGroup -Name "IT_Share_File1_RA" -GroupScope DomainLocal -GroupCategory Security -Description "IT Read Access" 
    New-ADGroup -Name "IT_Share_File1_CA" -GroupScope DomainLocal -GroupCategory Security -Description "IT Change Access" 
    New-ADGroup -Name "IT_Share_File1_FA" -GroupScope DomainLocal -GroupCategory Security -Description "IT Full Access"
    Add-ADGroupMember -Identity "IT" -Members "IT_Share_File1_FA"
    
    New-ADGroup -Name "HR" -GroupScope DomainLocal
    New-ADGroup -Name "HR_Share_File1_RA" -GroupScope DomainLocal -GroupCategory Security -Description "HR Read Access" 
    New-ADGroup -Name "HR_Share_File1_CA" -GroupScope DomainLocal -GroupCategory Security -Description "HR Change Access" 
    New-ADGroup -Name "HR_Share_File1_FA" -GroupScope DomainLocal -GroupCategory Security -Description "HR Full Access"
    Add-ADGroupMember -Identity "HR" -Members "HR_Share_File1_FA", "IT_Share_File1_RA"
    
    New-ADGroup -Name "Salg" -GroupScope DomainLocal
    New-ADGroup -Name "Salg_Share_File1_RA" -GroupScope DomainLocal -GroupCategory Security -Description "Salg Read Access" 
    New-ADGroup -Name "Salg_Share_File1_CA" -GroupScope DomainLocal -GroupCategory Security -Description "Salg Change Access" 
    New-ADGroup -Name "Salg_Share_File1_FA" -GroupScope DomainLocal -GroupCategory Security -Description "Salg Full Access"
    Add-ADGroupMember -Identity "Salg" -Members "Salg_Share_File1_FA"
}

ADDCOpsætning