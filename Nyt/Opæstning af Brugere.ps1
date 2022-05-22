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