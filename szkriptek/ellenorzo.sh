#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit


hibak=0
port_check() {
	local kod
	kod="$(curl -s -o /dev/null -w '%{http_code}\n' http://localhost:"$1")"
	if [[ "$kod" -eq 200 ]]; then
		return 0
	else
		return 1
	fi
}

szolgaltatas_fut() {
	local allapot
	allapot="$(docker inspect -f '{{.State.Status}}' "$1")"
	if [[ "$allapot" == "running" ]]; then
		return 0
	else
		return 1
	fi
}

ellenoriz() {
	local nev
	nev="$1"
	shift
	if "$@"; then
		printf '%s: OK\n' "$nev"
	else
		hibak=$((hibak + 1))
		printf '%s: HIBA\n' "$nev" >&2
	fi
}


## Szolgaltatas ellenorzes

a_cim='projekt-weboldal-1'
b_cim='projekt-weboldal2-1'
c_cim='projekt-weboldal3-1'

ellenoriz "[$a_cim] szolgaltatas ellenorzes" szolgaltatas_fut "$a_cim"
ellenoriz "[$b_cim] szolgaltatas ellenorzes" szolgaltatas_fut "$b_cim"
ellenoriz "[$c_cim] szolgaltatas ellenorzese" szolgaltatas_fut "$c_cim"

## Port ellenorzes

a_port='8080'
b_port='8081'
c_port='8082'

ellenoriz "[$a_port] port ellenorzes" port_check "$a_port"
ellenoriz "[$b_port] port ellenorzes" port_check "$b_port"
ellenoriz "[$c_port] port ellenorzes" port_check "$c_port"

if [[ "$hibak" -gt 0 ]]; then
	exit 1
else
	exit 0
fi
