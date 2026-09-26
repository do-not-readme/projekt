#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit


[[ $# -eq 0 ]] && echo "Ures argumentum" && exit 1

db=0
printf 'Varakozas a %s portra' "$1"
while [[ "$db" -lt 30 ]]; do
	printf '.'
	kod="$(curl -s -o /dev/null --max-time 1 -w '%{http_code}\n' http://localhost:"$1")" || kod=000
	if [[ "$kod" -eq 200 ]]; then
		printf '\nA %s port \e[92mELERHETO\e[0m\n' "$1"
		exit 0

	else
		db=$((db + 1))
		sleep 1
	fi
done
printf '\nA %s port \e[91mNEM ELERHETO\e[0m\n' "$1" >&2

exit 1

