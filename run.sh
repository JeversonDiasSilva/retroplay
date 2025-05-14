#!/bin/bash
# Curitiba 14 de Maio de 2025
# Editor Jeverson Dias da Silva


##############

### Instalar o fbalpha2012

##############




url="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/SISTEMA"
squash=$(basename "$url")
echo "$squash"
work="/usr/share/retroluxxo"
run="$work/scripts"

echo "# ------------ A - Configuração das teclas atribuídas ao sistema comercial ----------- #
# @JCGAMESCLASSICOS
# hotkey.conf
botao_coin=9
botao_sair=7
tempo_sair=3
" | cat - /userdata/system/batocera.conf > /tmp/batocera.tmp && mv /tmp/batocera.tmp /userdata/system/batocera.conf




wget "$url"

unsquashfs -d "work" "$squash"

rm "$squash"
chmod -R 777 "$work"


## ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????/
ln -s "$scripts"/load.sh /userdata/bin/load
ln -s "$scripts"/launcher_on /userdata/bin/launcher_on
ln -s "$scripts"/launcher_off /userdata/bin/launcher_off
ln-s $scripts/loop.sh

cp "$work"/dep/wmctrl /usr/bin
cp "$work"/dep/xdotool /usr/bin

mv "/usr/share/emulationstation/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg.bkp"
mv "/userdata/system/configs/emulationstation/es_systems.cfg" "/userdata/system/configs/emulationstation/es_systems.cfg.bkp"
cp "$work/emulationstation/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg"



sed -i '/# ulimit -c unlimited/a\
python3 /usr/share/retroluxxo/scripts/coin.py > /dev/null 2>\&1 &\n/usr/share/retroluxxo/scripts/loop.sh > /dev/null 2>\&1 &' /etc/X11/xinit/xinitrc

batocera-save-overlay

