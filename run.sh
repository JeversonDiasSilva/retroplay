#!/bin/bash

# Baixa o arquivo run.jc da URL fornecida
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc

# Verifica se o arquivo foi baixado corretamente
if [ -f "run.jc" ]; then
    # Dá permissão de execução ao arquivo
    chmod +x run.jc
else
    echo "Erro: O arquivo run.jc não foi baixado corretamente."
    exit 1
fi

# Interação para a chave de instalação
URL="https://raw.githubusercontent.com/JeversonDiasSilva/data/main/db.txt"
LISTA=$(curl -s "$URL")

echo -e "\nDigite a chave de instalação para continuar:"
read -p ":: " CHAVE

# Verifica se a chave é válida
if echo "$LISTA" | grep -qx "$CHAVE"; then
    echo -e "✔ Chave válida. Continuando a instalação..."
    ./run.jc  # Executa o script run.jc após chave válida
else
    echo -e "✘ Chave inválida."
    echo -e "Procure suporte técnico: Retrô LuXXo - WHATS (41) 99820-5080"
    exit 1
fi
