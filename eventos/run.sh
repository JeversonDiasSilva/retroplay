#!/bin/bash

# Passo 1: Baixar o arquivo para /usr/bin
echo "[info] Baixando os arquivos xdotool e eventos..."
if [ ! -f /usr/bin/evento ]; then
    curl -sSL https://raw.githubusercontent.com/JeversonDiasSilva/retroplay/refs/heads/main/eventos/eventos -o /usr/bin/evento
    chmod +x /usr/bin/evento
fi

# Passo 2: Baixar xdotool caso não exista
if [ ! -f /usr/bin/xdotool ]; then
    curl -sSL https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/xdotool -o /usr/bin/xdotool
    chmod +x /usr/bin/xdotool
fi

# Passo 3: Escrever no arquivo /etc/X11/xinit/xinitrc
echo "[info] Escrevendo no arquivo /etc/X11/xinit/xinitrc..."
sed -i '/# ulimit -c unlimited/a evento &' /etc/X11/xinit/xinitrc

# Passo 4: Rodar batocera-save-overlay
echo "[info] Rodando batocera-save-overlay..."
batocera-save-overlay

# Passo 5: Rodar o script evento em segundo plano
echo "[info] Rodando 'evento &'..."
if [ -z "$DISPLAY" ]; then
    startx
else
    echo "[warning] X já está em execução."
fi

# Passo 6: Finalizar o pcmanfm, se necessário
echo "[info] Finalizando o processo pcmanfm..."
killall -9 pcmanfm || echo "[warning] Não foi possível finalizar o processo pcmanfm."
