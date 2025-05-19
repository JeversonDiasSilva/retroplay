#!/bin/bash

# Baixa o arquivo run.jc corretamente e executa
wget https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc -O run.jc && chmod +x run.jc && ./run.jc

# Usando curl para baixar e executar diretamente
curl -Sl https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc | bash
