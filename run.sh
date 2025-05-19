#!/bin/bash

# Baixa o arquivo run.jc da URL fornecida
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc

# Verifica se o arquivo foi baixado corretamente
if [ -f "run.jc" ]; then
    # Dá permissão de execução ao arquivo
    chmod +x run.jc

    # Executa o arquivo
    ./run.jc
else
    echo "Erro: O arquivo run.jc não foi baixado corretamente."
    exit 1
fi
