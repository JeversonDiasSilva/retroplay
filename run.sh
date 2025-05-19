#!/bin/bash

# Passo 1: Baixar o arquivo do GitHub
echo "Baixando o arquivo..."
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc > /dev/null 2>&1

chmod +x run.jc
xdotool type "./run.jc"
