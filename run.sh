#!/bin/bash
# Curitiba 14 de Maio de 2025
# Editor Jeverson Dias da Silva


##############



##############




url="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/SISTEMA"
url_tema="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/PandoraPlus-master"
squash=$(basename "$url")
squash_tema=$(basename "$url_tema")
echo "$squash"
work="/usr/share/retroluxxo"
work_tema="/userdata/theme"
run="$work/scripts"
### Instalar o fbalpha2012 e ++++
url_retroarch="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/RETROARCH-CONFIG"
squash_retroarch=$(basename "$url_retroarch")
work_retroarch=/userdata/system/configs/retroarch


url_roms="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/FBA-ROMS"
squash_roms=$(basename "$url_roms")
work_roms="/userdata/roms/fba_libretro"

echo "# ------------ A - Configuração das teclas atribuídas ao sistema comercial ----------- #
# @JCGAMESCLASSICOS
# GENERIC XBOX 360 
botao_coin=9
botao_sair=7
tempo_sair=3
" | cat - /userdata/system/batocera.conf > /tmp/batocera.tmp && mv /tmp/batocera.tmp /userdata/system/batocera.conf



wget "$url"
wget "$url_tema"
wget "$url_retroarch"
wget "$url_roms"
unsquashfs -d "$work" "$squash"
unsquashfs -d "$work_tema" "$squash_tema"
unsquashfs -d "$work_retroarch" "$squash_retroarch"
unsquashfs -d "$work_roms" "$squash_roms"


#if [ -d /userdata/system/configs/retroarch]; then
#    mv /userdata/system/configs/retroarch /userdata/system/configs/retroarch.old
#fi


rm "$squash"
rm "$squash_tema"
rm $squash_roms
rm "$squash_retroarch"
chmod -R 777 "$work"
ln -s "$work_retroarch"/fbalpha2012_libretro.so /usr/bin/fbalpha2012_libretro.so
ln -s "$work_retroarch"/fbneo_libretro.so /usr/bin/fbneo_libretro.so


## binários ou aberots eis a questão...????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????/
ln -s "$run"/load.sh /userdata/bin/load
ln -s "$run"/launcher_on /userdata/bin/launcher_on
ln -s "$run"/launcher_off /userdata/bin/launcher_off
ln-s $run/loop.sh

cp "$work"/dep/wmctrl /usr/bin
cp "$work"/dep/xdotool /usr/bin

mv "/usr/share/emulationstation/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg.bkp"
mv "/userdata/system/configs/emulationstation/es_systems.cfg" "/userdata/system/configs/emulationstation/es_systems.cfg.bkp"
cp "$work/scripts/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg"



sed -i '/# ulimit -c unlimited/a\
python3 /usr/share/retroluxxo/scripts/coin.py > /dev/null 2>\&1 &\n/usr/share/retroluxxo/scripts/loop.sh > /dev/null 2>\&1 &' /etc/X11/xinit/xinitrc
chattr -i /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg
rm /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg

batocera-save-overlay
# curl -sL bit.ly/JCGAMES-FBA | bash

