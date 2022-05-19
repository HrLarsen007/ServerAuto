# Setting Variables that would be needed to setup the services

$DomainName = Read-Host "Domain Navn (Example: Spaceballs)"
$DomainEnd = Read-Host "Domain end  (Example: com"
$DomainPcName = Read-Host "PC Name (Example: DC1)"

# Install ADDS Service
$ConfirmPreference="high"
function Install_ADDS {
    [CmdletBinding(
    SupportsShouldProcess = $true,
    ConfirmImpact = 'High')]
    param($param)
    if ($PSCmdlet.ShouldProcess($param)) {
        Add-WindowsFeature AD-Domain-Services
        Import-Module ADDSDeployment

        Install-ADDSForest -DomainName "$($DomainName).$($DomainEnd)" -InstallDNS -NoRebootOnCompletion

        New-ADOrganizationalUnit -Name "BrugerAccounts" -Path "DC="$($DomainName)",DC="$($DomainEnd)""
        $amountOfGroups = Read-HosT "Hvor mange groups vil du lave?"
        for($i=0; $i -le $amountOfGroups; $i++){
            $tmp_group = Read-Host "Group Navn"
            New-ADGroup -Name $tmp_group -GroupScope DomainLocal
            New-ADGroup -Name "$($tmp_group)_Share_File1_RA" -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Read Access" 
            New-ADGroup -Name "$($tmp_group)_Share_File1_CA" -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Change Access" 
            New-ADGroup -Name "$($tmp_group)_Share_File1_FA" -GroupScope DomainLocal -GroupCategory Security -Description "$tmp_group Full Access"
            Add-ADGroupMember -Identity $tmp_group -Members "$($tmp_group)_Share_File1_RA","$($tmp_group)_Share_File1_CA","$($tmp_group)_Share_File1_FA"
        }

        $amountOfUsers = Read-Host "Hvor mange brugere vil du lave?"
        for($i=0; $i -le $amountOfUsers; $i++){
            $tmp_navn = Read-Host "Navn"
            $tmp_department = Read-Host "Afdeling"

            New-ADUser -Name "$tmp_navn" -Accountpassword (Read-Host -AsSecureString "Password")  -Path "OU=BrugerAccounts, DC="$($DomainName)", DC="$($DomainEnd)"" -Enabled $true
            Add-ADGroupMember -Identity "$tmp_department" -Members "$tmp_navn"
        }
    }
}

function Install_DHCP {
    [CmdletBinding(
    SupportsShouldProcess = $true,
    ConfirmImpact = 'High')]
    param($param)
    if ($PSCmdlet.ShouldProcess($param)) {
        #Install DHCP
        Install-WindowsFeature DHCP -IncludeManagementTools

        #Create DHCP security group
        netsh dhcp add securitygroups

        #Restart DHCP Service
        Restart-Service dhcpserver

        #Authorize the DHCP-Server
        Add-DhcpServerInDC -DnsName "$($DomainPcName).$($DomainName).$($DomainEnd)" -IPAddress 192.168.1.2

        #Enable Dynamic DNS updates
        Set-DhcpServerv4DnsSetting -ComputerName "$($DomainPcName).$($DomainName).$($DomainEnd)" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True

        #Configure the scope
        Add-DhcpServerv4Scope -name "$DomainName" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -State Active
        Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10
        Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0
        Set-DhcpServerv4OptionValue -DnsDomain "$($DomainName).$($DomainEnd)" -DnsServer 192.168.1.2
    }
}

function Install_SHARE {
    [CmdletBinding(
    SupportsShouldProcess = $true,
    ConfirmImpact = 'High')]
    param($param)
    if ($PSCmdlet.ShouldProcess($param)) {

        Install-WindowsFeature File-Services
        md C:\File1\Salg
        md C:\File1\HR
        md C:\File1\IT
        New-SmbShare -Name IT -Path C:\File1\Salg -EncryptData $True -FullAccess IT_Share_File1_FA -ReadAccess HR_Share_File1_RA, Salg_Share_File1_RA
        New-SmbShare -Name HR -Path C:\File1\HR -EncryptData $True -FullAccess IT_Share_File1_FA -ChangeAccess HR_Share_File1_CA
        New-SmbShare -name Salg -Path C:\File1\Salg -EncryptData $True -FullAccess IT_Share_File1_FA -ChangeAccess Salg_Share_File1_CA
    }
}

Install_ADDS
Install_DHCP
Install_SHARE