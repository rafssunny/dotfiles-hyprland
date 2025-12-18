#!/bin/bash

# Diretório onde seus wallpapers estão
WALL_DIR="/home/rafa/Imagens/wallpapers"

# Pega a lista de arquivos normal (só nomes)
choice=$(ls "$WALL_DIR" | wofi --dmenu --prompt "Pesquisar wallpaper")

# Se escolheu algo, aplica
if [ -n "$choice" ]; then
    swww img "$WALL_DIR/$choice" --transition-type grow --transition-duration 0.7
fi
