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

ellenoriz_szolgaltatas() {
	if szolgaltatas_fut "$1"; then
		printf 'A %s szolgaltatas \e[92mFUT\e[0m \n' "$1"
	else
		printf 'A %s szolgaltatas \e[91mNEM FUT\e[0m \n' "$1"
		hibak=$((hibak + 1))
	fi
}

ellenoriz_port() {
	if port_check "$1"; then
		printf 'A %s port \e[92mNYITVA\e[0m \n' "$1"
	else
		printf 'A %s port \e[91mZARVA\e[0m \n' "$1"
		hibak=$((hibak + 1))
	fi
}

## Szolgaltatas ellenorzes

a_cim='projekt-weboldal-1'
b_cim='projekt-weboldal2-1'
c_cim='projekt-weboldal3-1'

ellenoriz_szolgaltatas "$a_cim"
ellenoriz_szolgaltatas "$b_cim"
ellenoriz_szolgaltatas "$c_cim"

## Port ellenorzes

a_port='8080'
b_port='8081'
c_port='8082'

ellenoriz_port "$a_port"
ellenoriz_port "$b_port"
ellenoriz_port "$c_port"

if [[ "$hibak" -gt 0 ]]; then
	exit 1
else
	exit 0
fi
