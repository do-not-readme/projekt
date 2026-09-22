#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

fajlszam() {
	local fajlok 
	fajlok="$(find "$1" -type f | wc -l)"
	printf '%d' "$fajlok"
}

for i in ~/projekt/weboldal*;
do
	nev=${i##*/}
	db="$(fajlszam "$i")"
	printf 'Mappa: %s\n' "$nev"
	printf 'Fajlok szama: \t%d\n' "$db"	
done
	
	
exit 0

