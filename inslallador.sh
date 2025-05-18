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
VERMELHO="\033[1;31m"
RESET="\033[0m"
BOLD="\033[1m"
UNDERLINE="\033[4m"

echo -e "${ROXO}${BOLD}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${ROXO}${BOLD}  INSTALAÇÃO DO APLICATIVO ${RESET} ${VERDE}RetroPlay${RESET}"
echo -e "${ROXO}${BOLD}  V40 E V41 - JEVERTON DIAS DA SILVA - 06 DE MAIO DE 2025  ${RESET}"
echo -e "${ROXO}${BOLD}╚══════════════════════════════════════════════════════════╝${RESET}"
sleep 2

# Chave de instalação 
# Se a chave estiver no documento, fazer a instalação...
# Se a chave não estiver no documento, contato suporte ... tudo formatado ...
: << "END"
# URL do arquivo db.txt no GitHub (raw)
URL="https://raw.githubusercontent.com/JeversonDiasSilva/data/main/db.txt"

# Lê o conteúdo do arquivo e armazena em uma variável
LISTA=$(curl -s "$URL")

# Solicita a entrada do usuário
read -p "Digite a chave: " CHAVE

# Verifica se a chave existe na lista
if echo "$LISTA" | grep -q "^$CHAVE$"; then
    echo "OKOK"
else
    echo -e "PROCURE SUPORTE\nRetrô LuXXo  WHATS (41) 998205080"
fi

END

# Configuração no batocera.conf
echo -e "${AZUL}✔ Atualizando configuração do sistema...${RESET}"
echo "# ------------Configuração das teclas atribuídas ao sistema comercial ----------- #
# @JCGAMESCLASSICOS
# GENERIC XBOX 360 
botao_coin=9
botao_sair=7
tempo_sair=3
" | cat - /userdata/system/batocera.conf > /tmp/batocera.tmp && mv /tmp/batocera.tmp /userdata/system/batocera.conf

# Configuração do sistema  inicialização
echo "<?xml version="1.0"?>
<config>
	<bool name="StartupOnGameList" value="true" />
	<string name="ShowFlags" value="auto" />
	<string name="StartupSystem" value="fba_libretro" />
	<string name="ThemeSet" value="PandoraPlus-master" />
</config> " > "/userdata/system/configs/emulationstation/es_settings.cfg"





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
ln -sf "$work/scripts/load.sh" /usr/bin/load
ln -sf "$work/scripts/Launcher_on.sh" /usr/bin/Launcher_on
ln -sf "$work/scripts/Launcher_off.sh" /usr/bin/Launcher_off
ln -sf "$work/scripts/loop.sh" /usr/bin/loop

# Copiando binários auxiliares
cp "$work/dep/wmctrl" /usr/bin
cp "$work/dep/xdotool" /usr/bin

# Backup e substituição do es_systems.cfg
mv "/usr/share/emulationstation/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg.bkp" > /dev/null 2>&1 
mv "/userdata/system/configs/emulationstation/es_systems.cfg" "/userdata/system/configs/emulationstation/es_systems.cfg.bkp" > /dev/null 2>&1 
cp "$work/scripts/es_systems.cfg" "/usr/share/emulationstation/es_systems.cfg" > /dev/null 2>&1

# Adiciona scripts ao xinitrc
sed -i '/# ulimit -c unlimited/a\
python3 /usr/share/retroluxxo/scripts/coin.py > /dev/null 2>\&1 &\n/usr/bin/loop > /dev/null 2>\&1 &' /etc/X11/xinit/xinitrc

# Remove configuração antiga
chattr -i /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg
rm -f /userdata/system/configs/emulationstation/es_systems_fba_libretro.cfg

# Salva mudanças permanentes
echo -e "${AZUL}✔ Salvando alterações no sistema (overlay)...${RESET}"
batocera-save-overlay

/etc/X11/xinit/xinitrc
Launcher_on

echo -e "${VERDE}${BOLD}✔ Instalação concluída com sucesso!${RESET}"
