$F�dsels�r = Read-Host ("Hvilket �r er du f�rst i?")
$Alder = (Get-date).Year - $F�dsels�r

if ($Alder -lt 1) {Write-host "NYF�DT! Du er desv�rre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 3) {Write-host "BABY! Du er desv�rre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 10) {Write-host "BARN! Du er desv�rre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 13) {Write-host "UNG! Du er desv�rre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 20) {Write-host "TEENAGER! Du er desv�rre ikke gammel nok til at blive ansat."}

elseif ($Alder -lt 45) {Write-host "VOKSEN! Tillykke du er ansat, KOM IGANG!!!."}

elseif ($Alder -gt 60) {Write-host "MIDDELALDERLIG! Du er desv�rre for gammel til at blive ansat."}

elseif ($Alder -gt 70) {Write-host "GAMMEL! Du er desv�rre for gammel til at blive ansat."}

elseif ($Alder -gt 70) {Write-host "METUSALEMS GAMMEL! Du er desv�rre for gammel til at blive ansat."}