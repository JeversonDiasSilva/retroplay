#!/bin/bash
# Curitiba, 14 de Maio de 2025
# Editor: Jeverson Dias da Silva

# Estilização visual
clear
echo -e "\n\n\n\n"

ROXO="\033[1;35m"
VERDE="\033[1;92m"
AZUL="\033[1;34m"
AMARELO="\033[1;33m"
RESET="\033[0m"
BOLD="\033[1m"
UNDERLINE="\033[4m"

echo -e "${ROXO}${BOLD}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${ROXO}${BOLD}  INSTALAÇÃO DO APLICATIVO ${RESET} ${VERDE}RetroPlay${RESET}"
echo -e "${ROXO}${BOLD}  V40 E V41 - JEVERTON DIAS DA SILVA - 06 DE MAIO DE 2025  ${RESET}"
echo -e "${ROXO}${BOLD}╚══════════════════════════════════════════════════════════╝${RESET}"
sleep 2

# Chave de instalação
echo -ne "${AMARELO}${BOLD}INSIRA A CHAVE DE INSTALAÇÃO:${RESET} "
IFS= read -r chave < /dev/tty
sleep 1
echo -e "${VERDE}✔ Chave inserida com sucesso.${RESET}"
sleep 1

# Configuração no batocera.conf
echo "${AZUL}✔ Atualizando configuração do sistema...${RESET}"
echo "# ------------ A - Configuração das teclas atribuídas ao sistema comercial ----------- #
# @JCGAMESCLASSICOS
# GENERIC XBOX 360 
botao_coin=9
botao_sair=7
tempo_sair=3
" | cat - /userdata/system/batocera.conf > /tmp/batocera.tmp && mv /tmp/batocera.tmp /userdata/system/batocera.conf

# Diretórios de destino
mkdir -p "/userdata/system/.dev"
echo "" > "/userdata/system/.dev"/count.txt
echo "" > "/userdata/system/.dev"/relogio.txt
work="/usr/share/retroluxxo"
work_tema="/userdata/themes/PandoraPlus-master"
work_retroarch="/userdata/system/configs/retroarch"
work_core="$work_retroarch/cores"
work_libretro="/usr/lib/libretro"
work_roms="/userdata/roms/fba_libretro"

# Função para instalar cada pacote
instalar_pacote() {
    nome="$1"
    url="$2"
    destino="$3"
    
    echo -e "${AZUL}→ Instalando ${BOLD}${nome}${RESET}${AZUL}...${RESET}"
    arquivo=$(basename "$url")
    
    wget -q "$url" -O "$arquivo"
    if [ -f "$arquivo" ]; then
        unsquashfs -d "$destino" "$arquivo" > /dev/null 2>&1
        rm -f "$arquivo"
        echo -e "${VERDE}✔ ${nome} instalado com sucesso.${RESET}"
        sleep 1
    else
        echo -e "${VERMELHO}✘ Falha ao baixar ${nome}.${RESET}"
        exit 1
    fi
}

# Pacote 1: SISTEMA
instalar_pacote "Sistema Principal" "https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/SISTEMA" "$work"

# Pacote 2: Tema PandoraPlus
instalar_pacote "Tema PandoraPlus" "https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/PandoraPlus-master" "$work_tema"

# Pacote 3: Retroarch Config
instalar_pacote "RetroArch Config" "https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/RETROARCH-CONFIG" "$work_retroarch"

# Pacote 4: ROMs
instalar_pacote "Pacote de ROMs" "https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/FBA-ROMS" "$work_roms"

# Permissões e links
chmod -R 777 "$work"
ln -sf "$work_core/fbalpha2012_libretro.so" "$work_libretro/fbalpha2012_libretro.so"
ln -sf "$work_core/fbneo_libretro.so" "$work_libretro/fbneo_libretro.so"
ln -sf "$work/scripts/load.sh" /userdata/bin/load
ln -sf "$work/scripts/Launcher_on.sh" /userdata/bin/Launcher_on
ln -sf "$work/scripts/Launcher_off.sh" /userdata/bin/Launcher_off
ln -sf "$work/scripts/loop.sh" /userdata/bin/loop

# Copiando binários auxiliares
cp "$work/dep/wmctrl" /usr/bin
cp "$work/dep/xdotool" /usr/bin

# Backup e substituição do es_systems.cfg
mv "/usr/share/emulationstation/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg.bkp"
mv "/userdata/system/configs/emulationstation/es_systems.cfg" "/userdata/system/configs/emulationstation/es_systems.cfg.bkp"
cp "$work/scripts/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg"

# Adiciona scripts ao xinitrc
sed -i '/# ulimit -c unlimited/a\
python3 /usr/share/retroluxxo/scripts/coin.py > /dev/null 2>\&1 &\n/usr/binloop > /dev/null 2>\&1 &' /etc/X11/xinit/xinitrc

# Remove configuração antiga
chattr -i /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg
rm -f /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg

# Salva mudanças permanentes
echo -e "${AZUL}✔ Salvando alterações no sistema (overlay)...${RESET}"
batocera-save-overlay

echo -e "${VERDE}${BOLD}✔ Instalação concluída com sucesso!${RESET}"
