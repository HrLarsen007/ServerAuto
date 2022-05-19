Add-WindowsFeature AD-Domain-Services
## et module til at gøre vores AD mere smooth
Import-Module ADDSDeployment

$DomainName = Read-Host "Domain Navn"

Install-ADDSForest -DomainName $DomainName.com -InstallDNS -NoRebootOnCompletion

New-ADOrganizationalUnit -Name "BrugerAccounts" -Path "DC=$DomainName,DC=COM"

$amountOfGroups = Read-HosT "Hvor mange groups vil du lave?"
for($i=0; $i -le $amountOfGroups; $i++){
    $tmp_group = Read-Host "Group Navn"
    New-ADGroup -Name $tmp_group -GroupScope Global
    New-ADGroup -Name $tmp_group_Share_File1_RA -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Read Access" 
    New-ADGroup -Name $tmp_group_Share_File1_CA -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Change Access" 
    New-ADGroup -Name $tmp_group_Share_File1_FA -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Full Access"
    Add-ADGroupMember -Identity $tmp_group -Members $tmp_group_Share_File1_RA,$tmp_group_Share_File1_CA,$tmp_group_Share_File1_FA
}

$amountOfUsers = Read-Host "Hvor mange brugere vil du lave?"
for($i=0; $i -le $amountOfUsers; $i++){
    $tmp_navn = Read-Host "Navn"
    $tmp_department = Read-Host "Afdeling"

    New-ADUser -Name $tmp_navn -Accountpassword (Read-Host -AsSecureString "Password for $tmp_navn")  -path "OU=BrugerAccounts, DC=$DomainName, DC=com" -Enabled $true
    Add-ADGroupMember -Identity $tmp_department -Members $tmp_navn
}

#Install DHCP
Install-WindowsFeature DHCP -IncludeManagementTools

#Create DHCP security group
netsh dhcp add securitygroups

#Restart DHCP Service
Restart-Service dhcpserver

#Authorize the DHCP-Server
Add-DhcpServerInDC -DnsName DC1.WindowsSux.com -IPAddress 192.168.1.2

#Enable Dynamic DNS updates
Set-DhcpServerv4DnsSetting -ComputerName "DC1.WindowsSux.com" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

#Configure the scope
Add-DhcpServerv4Scope -name "WindowsSux" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0 -ComputerName pfsense.WindowsSux.com
Set-DhcpServerv4OptionValue -DnsDomain WindowsSux.com -DnsServer 192.168.1.2