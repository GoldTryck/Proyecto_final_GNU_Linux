#!/bin/bash

#############################################################################################################################################
#                                                                                                                                           #
#                                                     Explicación del archivo                                                               #
#                                                                                                                                           #        
#############################################################################################################################################


# Este archivo contiene las instrucciónes para el cómando feho que muestra la fecha y hora.
#
# Integrantes del equipo:
#       - Balam Flores Gabriel Patricio
#       - Larios Ponce Hector Manuel
#
# Utilidad: bienvenida.

#############################################################################################################################################
#                                                                                                                                           #
#                                            Comandos para cambiar de color las impresiones                                                 #
#                                                                                                                                           #        
#############################################################################################################################################

n="\033[30m"
r="\033[31m"
v="\033[32m"
am="\033[33m"
az="\033[34m"
m="\033[35m"
t="\033[36m"
b="\033[37m"
bold=$(tput bold)
normal=$(tput sgr0)

RGB=(${r} ${m} ${az} ${t} ${v} ${am})

#############################################################################################################################################
#                                                                                                                                           #
#                                                                  Comando                                                                  #
#                                                                                                                                           #        
#############################################################################################################################################

laberinto=(
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
  "🟩🐧⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜🐂🟩"
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

imprimir_laberinto () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"
    echo -e "\t${bold}${RGB[$i_carga]}Cargando: $carga%\n"
    for ((i = 0; i < ${#laberinto[@]}; i++)); do
        echo -e "   ${laberinto[$i]}"
    done
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"
}

localizar_pinguino1 () {

    for ((fila = 0; fila < ${#laberinto[@]}; fila++)); do
        if [[ "${laberinto[$fila]}" == *"🐧"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columna=$(($(expr index "${laberinto[$fila]}" "🐧")-1))
            break
        fi
    done
}

localizar_gnu1 () {

    for ((filaGnu = 0; filaGnu < ${#laberinto[@]}; filaGnu++)); do
        if [[ "${laberinto[$filaGnu]}" == *"🐂"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columnaGnu=$(($(expr index "${laberinto[$filaGnu]}" "🐂")-1))
            break
        fi
    done
}

# Función para mover al jugador
mover_jugador1 () {
    local nuevo_fila=$(($fila + $1))
    local nuevo_columna=$(($columna + $2))

    # Verificar si el nuevo movimiento es válido.
    if [[ ${laberinto[$nuevo_fila]:$nuevo_columna:1} != "🟩" ]]; then
        laberinto[$fila]=${laberinto[$fila]:0:$columna}"⬜"${laberinto[$fila]:$((columna+1))}
        fila=$nuevo_fila
        columna=$nuevo_columna
        laberinto[$fila]=${laberinto[$fila]:0:$columna}"🐧"${laberinto[$fila]:$((columna+1))}
    fi

    # Verifica si el nuevo movimiento es la victoria.
    if [ $fila == $filaGnu ] && [ $columna == $columnaGnu ]; then
        salidalaberinto=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab1 () {

    localizar_pinguino1
    localizar_gnu1
    carga=0
    i_carga=0
    while [ $salidalaberinto != 1 ]; do
        imprimir_laberinto        
        mover_jugador1 0 1
        if [ $i_carga == 6 ]; then
            i_carga=-1
        fi
        ((i_carga++))
        carga=$(($carga+5))
        sleep 0.2
    done
}

salidalaberinto=0
lab1

sleep 1
clear

printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

printf "\n  🟫🟨🟨🟨🟨 🟫🟨🟨🟨 🟫🟨🟨🟨 🟫🟨    🟫🟨 🟫🟨    🟫🟨 🟫🟨🟨🟨 🟫🟨    🟫🟨 🟫🟨🟨🟨 🟫🟨🟨🟨     🟫🟨🟨 "
printf "\n  🟫🟨  🟫🟨   🟫🟨   🟫🟨     🟫🟨🟨  🟫🟨 🟫🟨    🟫🟨 🟫🟨     🟫🟨🟨  🟫🟨   🟫🟨   🟫🟨  🟫🟨 🟫🟨  🟫🟨"
printf "\n  🟫🟨🟫🟨     🟫🟨   🟫🟨🟨   🟫🟨🟫🟨🟫🟨 🟫🟨    🟫🟨 🟫🟨🟨   🟫🟨🟫🟨🟫🟨   🟫🟨   🟫🟨  🟫🟨 🟫🟨🟨🟨🟨"
printf "\n  🟫🟨  🟫🟨   🟫🟨   🟫🟨     🟫🟨  🟫🟨🟨   🟫🟨🟫🟨   🟫🟨     🟫🟨  🟫🟨🟨   🟫🟨   🟫🟨  🟫🟨 🟫🟨  🟫🟨"
printf "\n  🟫🟨🟨🟨🟨 🟫🟨🟨🟨 🟫🟨🟨🟨 🟫🟨    🟫🟨     🟫🟨     🟫🟨🟨🟨 🟫🟨    🟫🟨 🟫🟨🟨🟨 🟫🟨🟨🟨   🟫🟨  🟫🟨\n"
 
printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"