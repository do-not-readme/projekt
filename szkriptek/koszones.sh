#!/bin/bash


printf 'Program neve: %s\n' "$0"
printf 'Argumentumok szama: %d\n' "$#"
printf 'Az elso argumentum: "%s"\n' "$1"
printf 'A masodik argumentum: %s\n' "$2"
printf 'Add meg a neved: '
read nev
printf 'Szia %s!\n' "$nev"
DATUM=$(date)
printf 'A pontos datum: %s\n' "$DATUM"
printf 'Ez egy fura program\n'
