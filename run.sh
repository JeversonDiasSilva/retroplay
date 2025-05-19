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

# Avisa o usuário que o script está pronto para rodar
echo -e "\nO arquivo run.jc foi baixado e está pronto para execução."

# Solicita ao usuário pressionar Enter para continuar
echo -e "Pressione Enter para executar o script run.jc..."
read  # Espera o pressionamento da tecla Enter

# Executa o arquivo run.jc
./run.jc
