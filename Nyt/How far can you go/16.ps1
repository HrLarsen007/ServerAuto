$Fødselsår = Read-Host ("Hvilket år er du først i?")
$Alder = (Get-date).Year - $Fødselsår

if ($Alder -lt 1) {Write-host "NYFØDT! Du er desværre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 3) {Write-host "BABY! Du er desværre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 10) {Write-host "BARN! Du er desværre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 13) {Write-host "UNG! Du er desværre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 20) {Write-host "TEENAGER! Du er desværre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 45) {Write-host "VOKSEN! Tillykke du er ansat, KOM IGANG!!!."}

elseif ($Alder -gt 60) {Write-host "MIDDELALDERLIG! Du er desværre for gammel til at blive ansat."}

elseif ($Alder -gt 70) {Write-host "GAMMEL! Du er desværre for gammel til at blive ansat."}

elseif ($Alder -gt 70) {Write-host "METUSALEMS GAMMEL! Du er desværre for gammel til at blive ansat."}