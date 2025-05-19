#!/bin/bash

# Passo 1: Baixar o arquivo do GitHub
echo "Baixando o arquivo..."
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc

# Passo 2: Exibir a mensagem e aguardar o usuário pressionar Enter para prosseguir
echo "Pressione ENTER para prosseguir"
read -p ""  # Espera o usuário pressionar Enter

# Passo 3: Rodar o comando ./run.jc
echo "Executando o comando ./run.jc..."
chmod +x run.jc  # Garantir permissão de execução
./run.jc
