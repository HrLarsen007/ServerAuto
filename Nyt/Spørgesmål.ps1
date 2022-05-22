# 1.       Kommando der kan vise firewall regler
Get-NetFirewallRule -All
# 2.       Kommando der kan ændre firewall regler, så f.eks. fjernskrivebord tillades.
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
# 3.       Kommando der kan oprette en GPO
New-GPO
# 4.       Kommando der kan enable/disable eller linke en GPO
Set-GPLink
# 5.       Kommando der kan vise grupper i ad
Get-ADGroup
# 6.       Kommando der kan vise medlemmer af en bestemt gruppe
Get-ADGroupMember -Identity 'HR'
# 7.       Kommando der kan vise hvilke grupper en bruger er medlem af
Get-ADPrincipalGroupMembership Billy | Select-Object name
# 8.       Kommando der kan liste alle AD brugere
Get-ADUser *
#  a.       Visningen skal liste forskellige attributer såsom ’Department’ etc.
Get-ADUser * -Properties 
#  b.       Output til fil
Get-ADUser * -Properties | Out-File -FilePath .\AdUserProperties.txt
# 9.       Kommando der kan liste alle disk på serveren, diskplads, samt resterende disk plads
Get-Volume
#  a.       Output til fil
Get-Volume | Out-File -FilePath .\disksinfo.txt
# 10.   Kommando der lister alle services og deres status m.m.
Get-Service | Select-Object -Property Name,Status,StartType
#  a.       Kørende services, i forhold til om de er sat til automatisk start
Get-Service | Select-Object -Property Name,Status,StartType | Where-Object {$_.Status -eq "Running" -and $_.StartType -eq "Automatic"}
#  b.       Output til fil
Get-Service | Select-Object -Property Name,Status,StartType | Where-Object {$_.Status -eq "Running" -and $_.StartType -eq "Automatic"} | Out-File -FilePath .\AutoRunService.txt
# 11.   Kommando der kan vise eventlogs
Get-EventLog -List
#  a.       De sidste 10
Get-EventLog -Newest 10
#  b.       For bestemte typer såsom warnings, errors etc.
Get-EventLog -EntryType Error
#  c.        For en række af servere
Get-EventLog -ComputerName Server1,Server2  
# 12.   Kommando der kan oprette et job til at køre et script hvert tiende minut
New-JobTrigger -Once -At "20/05/2013 16:00:00" -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration ([TimeSpan]::MaxValue)