$fødeår = Read-Host("Hvad årstal er du født i?")
$alder = (Get-Date).Year - $fødeår

if ($alder -le 1) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 2) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
} 
elseif ($alder -lt 5) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 9) {

   Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 18) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 39) {

    Write-Host("Du er ansat da du er i den aldersgruppe vi søger")
}
elseif ($alder -lt 59) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 60) {

    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
elseif ($alder -lt 100) {

   Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}
else {
    Write-Host("Du er desværre blevet afvist da du ikke er inden for den aldersgruppe vi søger")
}