#!/bin/bash

# Passo 1: Baixar o arquivo do GitHub
echo "Baixando o arquivo..."
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc > /dev/null 2>&1
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/xdotool -O xdotool > /dev/null 2>&1

# Passo 2: Tornar o arquivo executável
chmod +x run.jc
chmod +x xdotool

# Passo 3: Exibir a mensagem de instruções com formatação
echo -e "\e[1;31mPRESSIONE ENTER PARA PROSSEGUIR COM A INSTALAÇÃO\e[0m"  # Vermelho, caixa alta, em negrito
sleep 2.5
clear
# Usar o xdotool para digitar o comando
./xdotool type "./run.jc"
./xdotool key ctrl+l
sleep 2.5

# Remover xdotool se ele existir
if [ -f xdotool ]; then
    rm xdotool
    if [ $? -eq 0 ]; then
        echo "Arquivo xdotool removido com sucesso."
    else
        echo "Erro ao tentar remover o arquivo xdotool."
    fi
else
    echo "Arquivo xdotool não encontrado para remoção."
fi
