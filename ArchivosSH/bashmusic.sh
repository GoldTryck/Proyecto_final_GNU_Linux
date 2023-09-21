#!/bin/bash
if [ ! -d "$HOME/Biblioteca_musica" ]; then
  # Crear la carpeta
  mkdir "$HOME/Biblioteca_musica"
fi
MUSIC_LIBRARY="$HOME/Biblioteca_musica"

if [ ! -d "$HOME/Biblioteca_musica/playlists" ]; then
  # Crear la carpeta
  mkdir "$HOME/Biblioteca_musica/playlists"
fi
PLAYLIST_DIR="$HOME/Biblioteca_musica/playlists"
script_dir=$(dirname "$0")
cp -r "./Biblioteca"/* "$MUSIC_LIBRARY/"



cd "$MUSIC_LIBRARY"

# Lista de extensiones de archivo de música que deseas reproducir (puedes agregar más si es necesario)
extensions=("mp3" "ogg" "flac")

# Obtener una lista aleatoria de archivos en la biblioteca
shuffled_files=()
for ext in "${extensions[@]}"; do
    files=(*."$ext")
    shuffled_files+=( $(shuf -e "${files[@]}") )
done

# Bucle para reproducir canciones en orden aleatorio
for file in "${shuffled_files[@]}"; do
    if [ -f "$file" ]; then
        echo "Reproduciendo: $file"
        # Iniciar la reproducción de la canción
        mpg123 "$file" >/dev/null 2>&1
    fi
done
cd "$script_dir"