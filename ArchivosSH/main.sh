#!/bin/bash
source ./comandos.bashrc
#############################################################################################################################################
#                                                                                                                                           #
#                                                     Explicación del archivo                                                               #
#                                                                                                                                           #        
#############################################################################################################################################


# Este archivo muestra contiene el main de nuestro proyecto.
#
# Integrantes del equipo:
#       - Balam Flores Gabriel Patricio
#       - Larios Ponce Hector Manuel
#
# Comando: main.

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

#############################################################################################################################################
#                                                                                                                                           #
#                                                Comandos para ejecución                                                                    #
#                                                                                                                                           #        
#############################################################################################################################################

trap 'echo "No se puede salir con ctrl+c"' SIGINT
trap 'echo "No se puede salir con ctrl+c"' SIGTSTP

#############################################################################################################################################
#                                                                                                                                           #
#                                                Comandos de decoración                                                                     #
#                                                                                                                                           #        
#############################################################################################################################################
get_time() {
    hora=$(grep "rtc_time" /proc/driver/rtc | awk '{print $3}')
    IFS=":" read -ra time <<< "$hora"
    hour=${time[0]}
    min=${time[1]}
    sec=${time[2]}
    hour=$(($hour))
}
prompt () {
    get_time
    echo -ne "\n${az}╔╣ ${v}${bold}$(whoami)${b}${normal}@${t}${bold}$HOSTNAME ${normal}${az}╠══╣ ${m}${bold}$hour:$min:$sec ${normal}${az}║\n${az}╚═╣ ${r}${bold}$ ${normal}${az}╠═${bold}${r}>${v}>${t}>${normal}${b} "
    read comando
}

despedida () {
    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

    printf "\n  🟫🟨🟨🟨🟨 🟫🟨    🟫🟨 🟫🟨🟨🟨🟨🟨  🟫🟨🟨🟨"
    printf "\n  🟫🟨  🟫🟨   🟫🟨🟫🟨       🟫🟨      🟫🟨    "
    printf "\n  🟫🟨🟫🟨       🟫🟨         🟫🟨      🟫🟨🟨  "
    printf "\n  🟫🟨  🟫🟨     🟫🟨         🟫🟨      🟫🟨    "
    printf "\n  🟫🟨🟨🟨🟨     🟫🟨         🟫🟨      🟫🟨🟨🟨\n"

    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
}

#############################################################################################################################################
#                                                                                                                                           #
#                                                                main                                                                       #
#                                                                                                                                           #        
#############################################################################################################################################

main () {
    clear
    ./login.sh
    codigo_salida=$?
    if [ $codigo_salida -eq 0 ]; then
        ./inicio.sh
        comando=""
        until [ "$comando" = "exit" ]; do
            prompt
            case "$comando" in 
                "feho")
                    ./feho.sh
                    ;;
                
                "creditos")
                    ./creditos.sh
                    ;;
                
                "game")
                    ./game.sh
                    ;;
                
                "search")
                    ./search.sh
                    ;;
                
                "ayuda")
                    ./ayuda.sh
                    ;;
                
                "infosys")
                    ./infosys.sh
                    ;;

                "bashmusic")
                    ./bashmusic.sh
                    ;;
                
                "clear")
                    clear
                    printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"
                    ;;

                "exit")
                    despedida
                    ;;

                *)
                    echo -e "\n\t${r}***Error: comando no válido.${b}"
                    ;;
            esac
        done    
    fi
}

main

#############################################################################################################################################