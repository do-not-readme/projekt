# Tanuloprojekt
## Systemd gyakorlas (korabbi verzio)
- harom statikus weboldal
## ellenorzo szkriptek
### fajl-info.sh
- megvizsgalja, hogy egy fajl letezik-e
- mappa vagy fajl
- megnezi, hogy olvashato- es irhato-e
### oldal-info.sh
- megnezi, hogy hany fajl van a megadott mappakban
### ellenorzo.sh 
- ellenorzi a portot, tud-e hozza kapcsolodni
- fut-e a weboldal szolgaltatas


A systemd mappaban 3 weboldal szolgaltatas van, viszont az utvonalakat a sajat gephez kell igazitani

Ezert keszitettem egy konteneres valtozatot.

## A konteneres valtozat inditasa (aktualis verzio)
- `docker compose up -d`
- a weboldalak elerhetok a kovetkezo portokon: 8080, 8081, 8082
- ellenorzese a `./szkriptek/ellenorzo.sh`- al
