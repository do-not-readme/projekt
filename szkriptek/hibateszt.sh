#!/bin/bash

set -euo pipefail

trap 'printf "takaritas lefutott\n"' EXIT

printf 'elso lepes\n'
if ls /nemletezo 2>/dev/null; then
	printf 'letezik\n'
else
	printf 'nem letezik\n' >&2
	exit 3

	
fi

printf 'utolso lepes\n'
exit 0
