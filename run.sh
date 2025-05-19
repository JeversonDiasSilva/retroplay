#!/bin/bash

# Passo 1: Baixar o arquivo do GitHub
echo "Baixando o arquivo..."
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc > /dev/null 2>&1

# Passo 2: Exibir a mensagem com instruções sobre como executar o arquivo
echo ""
echo ""
echo ""
echo ""
echo "Arquivo baixado com sucesso!"
echo "Para executar o arquivo, use o comando:"
echo "./run.jc"
echo "Certifique-se de dar permissão de execução com o comando:"
echo "chmod +x run.jc"
