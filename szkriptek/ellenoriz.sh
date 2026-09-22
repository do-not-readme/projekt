#!/bin/bash

if [[ -z "$1" ]]; then
	printf 'Hasznalat: <%s> <utvonal>\n' "$0"
	exit 1
elif [[ -e "$1" ]]; then
	printf 'A %s letezik\n' "$1"
	if [[ -f "$1" ]]; then
		printf 'Ez egy fajl\n'
	elif [[ -d "$1" ]]; then 
		printf 'Ez egy mappa\n'
	else
		printf 'Nem fajl es nem mappa\n'
	fi
else
	printf 'A %s fajl nem letezik\n' "$1"
	exit 2
fi

[[ -r "$1" ]]
olvashato=$?
[[ -w "$1" ]]
irhato=$?

[[ "$olvashato" -eq 0 ]] && printf 'A fajl olvashato\n'
[[ "$irhato" -eq 0 ]] && printf 'A fajl irhato\n'
[[ "$olvashato" -ne 0 ]] && [[ "$irhato" -ne 0 ]] && printf 'A fajl nem olvashato es nem irhato\n'
exit 0
