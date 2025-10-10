#!/bin/bash

# Passo 1: Baixar o arquivo para /usr/bin
echo "[info] Baixando o arquivos xdotool e  eventos..."
curl -sSL https://raw.githubusercontent.com/JeversonDiasSilva/retroplay/refs/heads/main/eventos/eventos -o /usr/bin/evento
# Passo 2: Dar permissões de execução ao arquivo
echo "[info] Dando permissões de execução ao arquivo 'evento'..."
chmod +x /usr/bin/evento
if [ ! -f /usr/bin/xdotool ]; then
    curl -sSL https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/xdotool -o /usr/bin/xdotool
    chmod +x /usr/bin/xdotool
fi


# Passo 3: Escrever no arquivo /usr/bin/emulationstation-standalone
echo "[info] Escrevendo no arquivo emulationstation-standalone..."
sed -i '/# ulimit -c unlimited/a evento &' /etc/X11/xinit/xinitrc

# Passo 4: Rodar batocera-save-overlay
echo "[info] Rodando batocera-save-overlay..."
batocera-save-overlay

# Passo 5: Rodar o script evento em segundo plano
echo "[info] Rodando 'evento &'..."
startx
killall -9 pcmanfm 
