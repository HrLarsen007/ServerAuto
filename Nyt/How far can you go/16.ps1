$f�de�r = Read-Host("Hvad �rstal er du f�dt i?")
$alder = (Get-Date).Year - $f�de�r

if ($alder -le 1) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 2) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
} 
elseif ($alder -lt 5) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 9) {

   Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 18) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 39) {

    Write-Host("Du er ansat da du er i den aldersgruppe vi s�ger")
}
elseif ($alder -lt 59) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 60) {

    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
elseif ($alder -lt 100) {

   Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}
else {
    Write-Host("Du er desv�rre blevet afvist da du ikke er inden for den aldersgruppe vi s�ger")
}