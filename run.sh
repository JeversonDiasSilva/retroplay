#!/bin/bash

# Criar diretório para arquivos temporários
mkdir -p "/userdata/system/.dev/.tmp"
cd "/userdata/system/.dev/.tmp"

# Passo 1: Baixar os arquivos necessários do GitHub
echo -e "\033[1;32mINICIALIZANDO A INSTALAÇÃO...\033[0m"
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc > /dev/null 2>&1
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/xdotool -O xdotool > /dev/null 2>&1

# Passo 2: Tornar os arquivos executáveis
chmod +x run.jc
chmod +x xdotool

# Aguardar para garantir que os arquivos foram preparados
sleep 3

# Simular a digitação do caminho do script e pressionar Enter
echo -e "\033[1;35m./xdotool type \"cd /userdata/system/.dev/.tmp\"\033[0m"
./xdotool type "cd /userdata/system/.dev/.tmp"
sleep 2
./xdotool key Return
clear
echo -e "\033[1;35m./xdotool type \"./run.jc\"\033[0m"
./xdotool type "./run.jc"
sleep 2
./xdotool key Return

# Remover o arquivo xdotool se ele existir
if [ -f xdotool ]; then
    rm xdotool
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32mArquivo xdotool removido com sucesso.\033[0m"
    else
        echo -e "\033[1;31mErro ao tentar remover o arquivo xdotool.\033[0m"
    fi
else
    echo -e "\033[1;31mArquivo xdotool não encontrado para remoção.\033[0m"
fi

# Fim do script
: << "END"
END
