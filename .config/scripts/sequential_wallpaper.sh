#!/bin/bash

# Diretório contendo os wallpapers
WALLPAPER_DIR="$HOME/Imagens/wallpapers"
HISTORY_FILE="$HOME/.last_wallpaper"

# Lista todos os arquivos da pasta de wallpapers
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f | sort))

# Verifica se existem wallpapers
if [[ ${#WALLPAPERS[@]} -eq 0 ]]; then
    echo "Nenhum wallpaper encontrado em $WALLPAPER_DIR"
    exit 1
fi

# Lê o último wallpaper usado
if [[ -f "$HISTORY_FILE" ]]; then
    LAST_WALL=$(cat "$HISTORY_FILE")
else
    LAST_WALL=""
fi

# Encontra o próximo wallpaper na lista
NEXT_INDEX=0
for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$LAST_WALL" ]]; then
        NEXT_INDEX=$((i + 1))
        break
    fi
done

# Volta para o primeiro wallpaper se chegamos ao final
if [[ $NEXT_INDEX -ge ${#WALLPAPERS[@]} ]]; then
    NEXT_INDEX=0
fi

# Seleciona o wallpaper
WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

# Salva o wallpaper atual para a próxima execução
echo "$WALLPAPER" > "$HISTORY_FILE"

# Aplica o wallpaper usando Hyprpaper
swww img "$WALLPAPER" --transition-type grow --transition-duration 1
