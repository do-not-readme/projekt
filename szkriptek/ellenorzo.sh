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
		hibak=$((hibak + 1))
		return 1
	fi
}

szolgaltatas_fut() {
	systemctl --user is-active --quiet "$1"
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

a_cim='weboldal'
b_cim='weboldal2'

ellenoriz "[$a_cim] szolgaltatas ellenorzes" szolgaltatas_fut "$a_cim"
ellenoriz "[$b_cim] szolgaltatas ellenorzes" szolgaltatas_fut "$b_cim"


## Port ellenorzes

a_port='8000'
b_port='8001'

ellenoriz "[$a_port] port ellenorzes" port_check "$a_port"
ellenoriz "[$b_port] port ellenorzes" port_check "$b_port"


if [[ "$hibak" -gt 0 ]]; then
	exit 1
else
	exit 0
fi
