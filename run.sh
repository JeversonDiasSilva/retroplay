#!/bin/bash

url="https://github.com/JeversonDiasSilva/retroplay/releases/download/v1.0/run.jc"
app=$(basename "$url")

cd /userdata/extractions
wget "$url"
chmod +x "$app"
./"$app"
rm "$app"
