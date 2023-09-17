#!/bin/bash

#############################################################################################################################################
#                                                                                                                                           #
#                                                     Explicación del archivo                                                               #
#                                                                                                                                           #        
#############################################################################################################################################


# Este archivo muestra los créditos de la creación del proyecto.
#
# Integrantes del equipo:
#       - Balam Flores Gabriel Patricio
#       - Larios Ponce Hector Manuel
#
# Comando: game.


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

#############################################################################################################################################
#                                                                                                                                           #
#                                                             Funciones                                                                     #
#                                                                                                                                           #        
#############################################################################################################################################

numAleatorio () {
    local min=$1
    local max=$2
    aleatorio=$(($min + $RANDOM % $(($max-$min+1))))
}

#======================================================== Adivinar el número ========================================================
separar () {
    numero_str="$1"

    longitud=${#numero_str}

    arreglo=()

    # Itera a través de los dígitos y agrega cada dígito al arreglo
    for (( i = 0; i < $longitud; i++ )); do
        digito="${numero_str:$i:1}"
        arreglo+=("$digito")
    done

    numAleatorio 0 $(($longitud-1))
    pos=$aleatorio
}

pista() {
    numAleatorio 1 9
    local tipoPista=$aleatorio
    
    if [ $tipoPista -ge 1 ] && [ $tipoPista -le 5 ]; then
        # Mayor o menor
        if [ $1 -lt $2 ]; then # El número elegido es mayor al objetivo
            echo -e "\n\t${v}Pista: ${b} $2 es mayor al número a buscar."
        elif [ $1 -gt $2 ]; then
            echo -e "\n\t${v}Pista: ${b} $2 es menor al número a buscar."
        fi
    
    elif [ $tipoPista -ge 6 ] && [ $tipoPista -le 8 ]; then
        # Multiplo
        numAleatorio 2 10
        local mult=$aleatorio
        if [ $(($1 % $mult)) == 0 ]; then
            echo -e "\n\t${v}Pista: ${b} $mult es divisor del número a buscar."
        else
            echo -e "\n\t${v}Pista: ${b} $mult no es divisor del número a buscar."
        fi
    else
        separar $1
        elemento=${arreglo[$pos]}
        echo -e "\n\t${v}Pista: ${b} El número a buscar tiene un $elemento en la posición $(($pos + 1)) "
    fi        
}

adivina () {
    opcionAdv=0
    until [ $opcionAdv -eq 5 ]; do
        printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
        echo -e "\n\t${am}Adivina el número: "
        echo -e "\n\t${v}1) ${b}Fácil (2 dígitos)."
        echo -e "\n\t${v}2) ${b}Intermedio (3 dígitos)."
        echo -e "\n\t${v}3) ${b}Difícil (4 dígitos)."
        echo -e "\n\t${v}4) ${b}Experto (dígitos del 5 al 10)."
        echo -e "\n\t${v}5) ${b}Salir."
        echo -e "\n\n\t${t}Opción: ${b}\c"
        read opcionAdv
        salida=-1

        case $opcionAdv in 
            1)
                numAleatorio 10 99
                num=$aleatorio
                intentos=0
                until [ $salida -eq 0 ] || [ $salida -eq $num ]; do
                    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                    echo -e "\n\t${az}Nota: puedes salir esribiendo 0."
                    echo -e "\n\t${am}Adivina: ${b}\c"
                    read salida
                    ((intentos++))
                    if [ $salida -ne $num ] && [ $salida -ne 0 ]; then
                        pista $num $salida
                    fi
                done
                printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
                echo -e "\n\t${v}N° de intentos:${b} $intentos"
                ;;
            
            2)
                numAleatorio 100 999
                num=$aleatorio
                intentos=0
                until [ $salida -eq 0 ] || [ $salida -eq $num ]; do
                    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                    echo -e "\n\t${az}Nota: puedes salir esribiendo 0."
                    echo -e "\n\t${am}Adivina: ${b}\c"
                    read salida
                    ((intentos++))
                    if [ $salida -ne $num ] && [ $salida -ne 0 ]; then
                        pista $num $salida
                    fi
                done
                printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                echo -e "\n\t${t}FELICIDADES, has ganado."
                echo -e "\n\t${v}N° de intentos:${b} $intentos"
                ;;
            
            3)
                numAleatorio 1000 9999
                num=$aleatorio
                intentos=0
                until [ $salida -eq 0 ] || [ $salida -eq $num ]; do
                    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                    echo -e "\n\t${az}Nota: puedes salir esribiendo 0."
                    echo -e "\n\t${am}Adivina: ${b}\c"
                    read salida
                    ((intentos++))
                    if [ $salida -ne $num ] && [ $salida -ne 0 ]; then
                        pista $num $salida
                    fi
                done
                printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                echo -e "\n\t${t}FELICIDADES, has ganado."
                echo -e "\n\t${v}N° de intentos:${b} $intentos"
                ;;
            
            4)
                numAleatorio 5 10
                digits=$aleatorio
                inf=$((10 ** $((digits-1))))
                max=$(($inf * 10 - 1))
                numAleatorio $inf $max
                num=$aleatorio
                intentos=0
                until [ $salida -eq 0 ] || [ $salida -eq $num ]; do
                    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                    echo -e "\n\t${az}Nota: puedes salir esribiendo 0."
                    echo -e "\n\t${am}Adivina: ${b}\c"
                    read salida
                    ((intentos++))
                    if [ $salida -ne $num ] && [ $salida -ne 0 ]; then
                        pista $num $salida
                    fi
                done
                printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                echo -e "\n\t${t}FELICIDADES, has ganado."
                echo -e "\n\t${v}N° de intentos:${b} $intentos"
                ;;
            
            5)
                echo
                ;;
            
            *)
                printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                echo -e "\n\t${r}***Error: opción no válida."
                ;;
        esac
    done
}

#====================================================== Piedra, papel o tijeras =====================================================
ppt () {
    opcionPPT=0
    until [ $opcionPPT -eq 4 ]; do
        printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
        echo -e "\n\t${am}Piedra, papel o tijeras: "
        echo -e "\n\t${v}1) ${b}💎"
        echo -e "\n\t${v}2) ${b}🧻"
        echo -e "\n\t${v}3) ${b}✂️"
        echo -e "\n\t${v}4) ${b}Salir."
        echo -e "\n\n\t${t}Opción: ${b}\c"
        read opcionPPT

        numAleatorio 1 3
        num=$aleatorio
        
        if [ $opcionPPT == 4 ]; then
            echo
        elif [ $num == $opcionPPT ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            case $opcionPPT in
                1)
                    echo -e "\n\t💎 vs 💎"
                    ;;
                2)
                    echo -e "\n\t🧻 vs 🧻"
                    ;;
                3)
                    echo -e "\n\t✂️ vs ✂️"
                    ;;
            esac
            echo -e "\n\t${b}Empate 🤭"
            sleep 1
        
        elif [ $opcionPPT == 1 ] && [ $num == 2 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t💎 vs 🧻"
            echo -e "\n\t${r}Perdiste 😵"
            sleep 1

        elif [ $opcionPPT == 1 ] && [ $num == 3 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t💎 vs ✂️"
            echo -e "\n\t${v}GANASTE 🤩"
            sleep 1

        elif [ $opcionPPT == 2 ] && [ $num == 1 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t🧻 vs 💎"
            echo -e "\n\t${v}GANASTE 🤩"
            sleep 1

        elif [ $opcionPPT == 2 ] && [ $num == 3 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t🧻 vs ✂️"
            echo -e "\n\t${r}Perdiste 😵"
            sleep 1

        elif [ $opcionPPT == 3 ] && [ $num == 1 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t✂️ vs 💎"
            echo -e "\n\t${r}Perdiste 😵"
            sleep 1


        elif [ $opcionPPT == 3 ] && [ $num == 2 ]; then
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t✂️ vs 🧻"
            echo -e "\n\t${v}GANASTE 🤩"
            sleep 1
        else
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
            echo -e "\n\t${r}***Error: opción no válida."
        fi

    done
}



#############################################################################################################################################
#                                                                                                                                           #
#                                                             Laberinto 1                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################
nivel=0

laberinto=(
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
  "🟩🐧🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩"
  "🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩"
  "🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩"
  "🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩"
  "🟩⬜🟩⬜🟩⬜⬜🐂🟩⬜🟩⬜🟩"
  "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩"
  "🟩⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩"
  "🟩⬜🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜🟩"
  "🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩"
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

# Función para imprimir el laberinto:
imprimir_laberinto () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    for ((i = 0; i < ${#laberinto[@]}; i++)); do
        echo -e "\t${laberinto[$i]}"
    done

}

# Función para encontrar la ubicación del pingüino:
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
        echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
        salidalaberinto=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab1 () {

    localizar_pinguino1
    localizar_gnu1

    while [ $salidalaberinto != 1 ]; do

        imprimir_laberinto

        # Leer la entrada del jugador
        read -n 1 -s movimiento
        case $movimiento in
            "w")
                mover_jugador1 -1 0 
                ;;
            "s")
                mover_jugador1 1 0 
                ;;
            "a")
                mover_jugador1 0 -1 
                ;;
            "d")
                mover_jugador1 0 1 
                ;;
            "q") 
                echo -e "\n\t${r}¡Abandonaste el juego!"; break 
                ;;
        esac
    done
}

salidalaberinto=0

#############################################################################################################################################
#                                                                                                                                           #
#                                                             Laberinto 2                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################

laberinto2=(
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
  "🟩🐧🟩⬜⬜🟩⬜⬜⬜⬜⬜⬜🟩"
  "🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩"
  "🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩🟩🟩"
  "🟩🟩🟩⬜⬜⬜🟩🟩🟩🟩🟩⬜🟩"
  "🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩"
  "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩"
  "🟩⬜🟩⬜⬜🟩⬜⬜⬜⬜🟩⬜🟩"
  "🟩⬜🟩🟩🟩🟩⬜🟩🟩🟩🟩⬜🟩"
  "🟩⬜⬜⬜⬜⬜⬜⬜🟩🐂⬜⬜🟩"
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

imprimir_laberinto2 () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    for ((i = 0; i < ${#laberinto2[@]}; i++)); do
        echo -e "\t${laberinto2[$i]}"
    done

}

# Función para encontrar la ubicación del pingüino:
localizar_pinguino2 () {

    for ((fila = 0; fila < ${#laberinto2[@]}; fila++)); do
        if [[ "${laberinto2[$fila]}" == *"🐧"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columna=$(($(expr index "${laberinto2[$fila]}" "🐧")-1))
            break
        fi
    done
}

localizar_gnu2 () {

    for ((filaGnu = 0; filaGnu < ${#laberinto2[@]}; filaGnu++)); do
        if [[ "${laberinto2[$filaGnu]}" == *"🐂"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columnaGnu=$(($(expr index "${laberinto2[$filaGnu]}" "🐂")-1))
            break
        fi
    done
}

# Función para mover al jugador
mover_jugador2 () {
    local nuevo_fila=$(($fila + $1))
    local nuevo_columna=$(($columna + $2))

    # Verificar si el nuevo movimiento es válido.
    if [[ ${laberinto2[$nuevo_fila]:$nuevo_columna:1} != "🟩" ]]; then
        laberinto2[$fila]=${laberinto2[$fila]:0:$columna}"⬜"${laberinto2[$fila]:$((columna+1))}
        fila=$nuevo_fila
        columna=$nuevo_columna
        laberinto2[$fila]=${laberinto2[$fila]:0:$columna}"🐧"${laberinto2[$fila]:$((columna+1))}
    fi

    # Verifica si el nuevo movimiento es la victoria.
    if [ $fila == $filaGnu ] && [ $columna == $columnaGnu ]; then
        echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
        salidalaberinto2=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab2 () {

    localizar_pinguino2
    localizar_gnu2

    while [ $salidalaberinto2 != 1 ]; do

        imprimir_laberinto2

        # Leer la entrada del jugador
        read -n 1 -s movimiento
        case $movimiento in
            "w")
                mover_jugador2 -1 0 
                ;;
            "s")
                mover_jugador2 1 0 
                ;;
            "a")
                mover_jugador2 0 -1 
                ;;
            "d")
                mover_jugador2 0 1 
                ;;
            "q") 
                echo -e "\n\t${r}¡Abandonaste el juego!"; break 
                ;;
        esac
    done
}

salidalaberinto2=0

#############################################################################################################################################
#                                                                                                                                           #
#                                                             Laberinto 3                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################

laberinto3=(
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
  "🟩🐧⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩"
  "🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩"
  "🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜🐂🟩"
  "🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩"
  "🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩"
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩"
  "🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩"
  "🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩"
  "🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩"
  "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩"
  "🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩"
  "🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩"
  "🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩"
  "🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩"
  "🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩"
  "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

imprimir_laberinto3 () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    for ((i = 0; i < ${#laberinto3[@]}; i++)); do
        echo -e "\t${laberinto3[$i]}"
    done

}

# Función para encontrar la ubicación del pingüino:
localizar_pinguino3 () {

    for ((fila = 0; fila < ${#laberinto3[@]}; fila++)); do
        if [[ "${laberinto3[$fila]}" == *"🐧"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columna=$(($(expr index "${laberinto3[$fila]}" "🐧")-1))
            break
        fi
    done
}

localizar_gnu3 () {

    for ((filaGnu = 0; filaGnu < ${#laberinto3[@]}; filaGnu++)); do
        if [[ "${laberinto3[$filaGnu]}" == *"🐂"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columnaGnu=$(($(expr index "${laberinto3[$filaGnu]}" "🐂")-1))
            break
        fi
    done
}

# Función para mover al jugador
mover_jugador3 () {
    local nuevo_fila=$(($fila + $1))
    local nuevo_columna=$(($columna + $2))

    # Verificar si el nuevo movimiento es válido.
    if [[ ${laberinto3[$nuevo_fila]:$nuevo_columna:1} != "🟩" ]]; then
        laberinto3[$fila]=${laberinto3[$fila]:0:$columna}"⬜"${laberinto3[$fila]:$((columna+1))}
        fila=$nuevo_fila
        columna=$nuevo_columna
        laberinto3[$fila]=${laberinto3[$fila]:0:$columna}"🐧"${laberinto3[$fila]:$((columna+1))}
    fi

    # Verifica si el nuevo movimiento es la victoria.
    if [ $fila == $filaGnu ] && [ $columna == $columnaGnu ]; then
        echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
        salidalaberinto3=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab3 () {

    localizar_pinguino3
    localizar_gnu3

    while [ $salidalaberinto3 != 1 ]; do

        imprimir_laberinto3

        # Leer la entrada del jugador
        read -n 1 -s movimiento
        case $movimiento in
            "w")
                mover_jugador3 -1 0 
                ;;
            "s")
                mover_jugador3 1 0 
                ;;
            "a")
                mover_jugador3 0 -1 
                ;;
            "d")
                mover_jugador3 0 1 
                ;;
            "q") 
                echo -e "\n\t${r}¡Abandonaste el juego!"; break 
                ;;
        esac
    done
}

salidalaberinto3=0

#############################################################################################################################################
#                                                                                                                                           #
#                                                             Laberinto 4                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################

laberinto4=(
    "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
    "🟩🐧⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩"
    "🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩"
    "🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
    "🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩"
    "🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩"
    "🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩"
    "🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩"
    "🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩"
    "🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩"
    "🟩🟩🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩"
    "🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩"
    "🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩"
    "🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩"
    "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩"
    "🟩🐂🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩"
    "🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩"
    "🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩"
    "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

imprimir_laberinto4 () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    for ((i = 0; i < ${#laberinto4[@]}; i++)); do
        echo -e "\t${laberinto4[$i]}"
    done

}

# Función para encontrar la ubicación del pingüino:
localizar_pinguino4 () {

    for ((fila = 0; fila < ${#laberinto4[@]}; fila++)); do
        if [[ "${laberinto4[$fila]}" == *"🐧"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columna=$(($(expr index "${laberinto4[$fila]}" "🐧")-1))
            break
        fi
    done
}

localizar_gnu4 () {

    for ((filaGnu = 0; filaGnu < ${#laberinto4[@]}; filaGnu++)); do
        if [[ "${laberinto4[$filaGnu]}" == *"🐂"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columnaGnu=$(($(expr index "${laberinto4[$filaGnu]}" "🐂")-1))
            break
        fi
    done
}

# Función para mover al jugador
mover_jugador4 () {
    local nuevo_fila=$(($fila + $1))
    local nuevo_columna=$(($columna + $2))

    # Verificar si el nuevo movimiento es válido.
    if [[ ${laberinto4[$nuevo_fila]:$nuevo_columna:1} != "🟩" ]]; then
        laberinto4[$fila]=${laberinto4[$fila]:0:$columna}"⬜"${laberinto4[$fila]:$((columna+1))}
        fila=$nuevo_fila
        columna=$nuevo_columna
        laberinto4[$fila]=${laberinto4[$fila]:0:$columna}"🐧"${laberinto4[$fila]:$((columna+1))}
    fi

    # Verifica si el nuevo movimiento es la victoria.
    if [ $fila == $filaGnu ] && [ $columna == $columnaGnu ]; then
        echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
        salidalaberinto4=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab4 () {

    localizar_pinguino4
    localizar_gnu4

    while [ $salidalaberinto4 != 1 ]; do

        imprimir_laberinto4

        # Leer la entrada del jugador
        read -n 1 -s movimiento
        case $movimiento in
            "w")
                mover_jugador4 -1 0 
                ;;
            "s")
                mover_jugador4 1 0 
                ;;
            "a")
                mover_jugador4 0 -1 
                ;;
            "d")
                mover_jugador4 0 1 
                ;;
            "q") 
                echo -e "\n\t${r}¡Abandonaste el juego!"; break 
                ;;
        esac
    done
}


salidalaberinto4=0
 
#############################################################################################################################################
#                                                                                                                                           #
#                                                             Laberinto 5                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################

laberinto5=(
    "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
    "🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩"
    "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩"
    "🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩"
    "🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩"
    "🟩⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩"
    "🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩"
    "🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩"
    "🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩"
    "🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩"
    "🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩"
    "🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩"
    "🟩🟩🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩🟩🟩⬜🟩"
    "🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩"
    "🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩"
    "🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜⬜⬜🐂🟩"
    "🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩🟩🟩"
    "🟩🐧⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩"
    "🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩"
    "🟩⬜🟩🟩🟩🟩🟩⬜🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜🟩"
    "🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩"
    "🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩⬜🟩"
    "🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜🟩⬜🟩"
    "🟩⬜🟩🟩🟩⬜🟩⬜🟩🟩🟩⬜🟩⬜🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩⬜🟩"
    "🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜🟩⬜🟩⬜🟩"
    "🟩⬜🟩⬜🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩⬜🟩🟩🟩🟩🟩🟩🟩⬜🟩🟩🟩⬜🟩"
    "🟩⬜🟩⬜🟩⬜⬜⬜⬜⬜🟩⬜⬜⬜🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜🟩⬜⬜⬜⬜⬜🟩"
    "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩"
)

imprimir_laberinto5 () {
    clear
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    for ((i = 0; i < ${#laberinto5[@]}; i++)); do
        echo -e "\t${laberinto5[$i]}"
    done

}

# Función para encontrar la ubicación del pingüino:
localizar_pinguino5 () {

    for ((fila = 0; fila < ${#laberinto5[@]}; fila++)); do
        if [[ "${laberinto5[$fila]}" == *"🐧"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columna=$(($(expr index "${laberinto5[$fila]}" "🐧")-1))
            break
        fi
    done
}

localizar_gnu5 () {

    for ((filaGnu = 0; filaGnu < ${#laberinto5[@]}; filaGnu++)); do
        if [[ "${laberinto5[$filaGnu]}" == *"🐂"* ]]; then
            # expr index [arreglo] [caracter]: es una función que busca un caracter en un arreglo.
            columnaGnu=$(($(expr index "${laberinto5[$filaGnu]}" "🐂")-1))
            break
        fi
    done
}

# Función para mover al jugador
lmover_jugador5 () {
    local nuevo_fila=$(($fila + $1))
    local nuevo_columna=$(($columna + $2))

    # Verificar si el nuevo movimiento es válido.
    if [[ ${laberinto5[$nuevo_fila]:$nuevo_columna:1} != "🟩" ]]; then
        laberinto5[$fila]=${laberinto5[$fila]:0:$columna}"⬜"${laberinto5[$fila]:$((columna+1))}
        fila=$nuevo_fila
        columna=$nuevo_columna
        laberinto5[$fila]=${laberinto5[$fila]:0:$columna}"🐧"${laberinto5[$fila]:$((columna+1))}
    fi

    # Verifica si el nuevo movimiento es la victoria.
    if [ $fila == $filaGnu ] && [ $columna == $columnaGnu ]; then
        echo -e "\n\t${t}¡¡¡FELICIDADES, has ganado!!!"
        salidalaberinto5=1
        ((nivel++))
    fi
}

# Bucle principal del juego
lab5 () {

    localizar_pinguino5
    localizar_gnu5

    while [ $salidalaberinto5 != 1 ]; do

        imprimir_laberinto5

        # Leer la entrada del jugador
        read -n 1 -s movimiento
        case $movimiento in
            "w")
                lmover_jugador5 -1 0 
                ;;
            "s")
                lmover_jugador5 1 0 
                ;;
            "a")
                lmover_jugador5 0 -1 
                ;;
            "d")
                lmover_jugador5 0 1 
                ;;
            "q") 
                echo -e "\n\t${r}¡Abandonaste el juego!"; break 
                ;;
        esac
    done
}

salidalaberinto5=0

#############################################################################################################################################
#                                                                                                                                           #
#                                                               Main                                                                        #
#                                                                                                                                           #        
#############################################################################################################################################


printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

printf "\n  🟫🟨🟨🟨🟨    🟫🟨🟨    🟫🟨    🟫🟨  🟫🟨🟨🟨"
printf "\n  🟫🟨        🟫🟨  🟫🟨  🟫🟨🟨🟫🟨🟨  🟫🟨    "
printf "\n  🟫🟨🟨🟨🟨  🟫🟨🟨🟨🟨  🟫🟨🟫🟨🟫🟨  🟫🟨🟨  "
printf "\n  🟫🟨  🟫🟨  🟫🟨  🟫🟨  🟫🟨    🟫🟨  🟫🟨    "
printf "\n  🟫🟨🟨🟨🟨  🟫🟨  🟫🟨  🟫🟨    🟫🟨  🟫🟨🟨🟨\n"

opcion=0

until [ $opcion == 4 ]; do

    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"

    echo -e "\n\t${am}Elige el juego que quieras jugar: "
    echo -e "\n\t${v}1) ${b}Adivina el número."
    echo -e "\n\t${v}2) ${b}Piedra, papel o tijeras."
    echo -e "\n\t${v}3) ${b}Laberintos (w,a,s,d, q: salir)."
    echo -e "\n\t${v}4) ${b}Salir."
    echo -e "\n\n\t${t}Opción: ${b}\c"
    read opcion

    case $opcion in
        1)
            adivina
            ;;
        
        2)
            ppt
            ;;
        
        3)
            lab1
            if [ $nivel == 1 ]; then
                lab2
            fi 

            if [ $nivel == 2 ]; then
                lab3 
            fi 

            if [ $nivel == 3 ]; then
                lab4 
            fi 

            if [ $nivel == 4 ]; then
                lab5 
            fi
            ;;
        
        4)
            printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n\n"
            ;;
        
        *)
            echo -e "\n\t${r}***Error: opción no válida."
            ;;
    esac
done

#############################################################################################################################################