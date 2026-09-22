#!/bin/bash
set -euo pipefail

letezik() {
	if [[ -e "$1" ]]; then
		return 0
	else
		return 1
	fi
}

koszon() {
	local nev=${1:-'Ismeretlen'}
	printf 'Szia %s\n' "$nev"
	return 0
}

koszon "Zoli"
koszon 

a='/etc/hostname'
b='/nem/letezo/utvonal'

if letezik "$a"; then
	printf 'A %s utvonal\nLETEZIK\n' "$a"
else
	printf 'A %s utvonal\nNEM LETEZIK\n' "$a"
fi

if letezik "$b"; then
	printf 'A %s utvonal\nLETEZIK\n' "$b"
else
	printf 'A %s utvonal\nNEM LETEZIK\n' "$b"

fi

exit 0
