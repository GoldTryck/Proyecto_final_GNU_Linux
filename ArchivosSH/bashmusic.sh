#!/bin/bash
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
dir_script=$(pwd)
cd $HOME
show_opc() {
    echo -e "${bold}${m}$1 ${normal}${b}$2"
}
valida_rep() {
if ! command -v mpg123 &>/dev/null; then
    echo -e "${bold}${r}\nPara poder utilizar el reproductor de música, debe instalar el paquete mpg123."
    echo -e -n "${t}¿Desea realizar la instalación? [S/N] > ${normal}${b}"
    read opcion
    if [[ $opcion =~ ^[sS]$ ]]; then
        sudo apt install mpg123
        echo -e "${bold}${v}mpg123 se ha instalado correctamente. Puede utilizar el reproductor de música ahora.${normal}${b}"
        sleep 2
    else
        echo -e "${bold}${am}No se ha instalado mpg123. No podrá utilizar el reproductor de música.${normal}${b}"
        exit 1
    fi
fi
}
saludo () {
    	printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"

    	printf "\n  🟫🟨🟨🟨🟨 🟫🟨🟨🟨🟨  🟫🟨🟨🟨 🟫🟨  🟫🟨 🟫🟨    🟫🟨 🟫🟨  🟫🟨 🟫🟨🟨🟨 🟫🟨🟨🟨🟨  🟫🟨🟨"
    	printf "\n  🟫🟨  🟫🟨 🟫🟨  🟫🟨 🟫🟨      🟫🟨  🟫🟨 🟫🟨🟨🟫🟨🟨 🟫🟨  🟫🟨  🟫🟨       🟫🟨   🟫🟨"  
    	printf "\n  🟫🟨🟫🟨   🟫🟨🟨🟨🟨   🟫🟨    🟫🟨🟨🟨🟨 🟫🟨🟫🟨🟫🟨 🟫🟨  🟫🟨   🟫🟨      🟫🟨   🟫🟨"
    	printf "\n  🟫🟨  🟫🟨 🟫🟨  🟫🟨     🟫🟨  🟫🟨  🟫🟨 🟫🟨    🟫🟨 🟫🟨  🟫🟨    🟫🟨     🟫🟨    🟫🟨"
    	printf "\n  🟫🟨🟨🟨🟨 🟫🟨  🟫🟨  🟫🟨🟨🟨 🟫🟨  🟫🟨 🟫🟨    🟫🟨 🟫🟨🟨🟨🟨 🟫🟨🟨🟨 🟫🟨🟨🟨🟨  🟫🟨🟨\n"

    	printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"
}
cambiar_dir(){
	dir=()
  	echo -n "Ingrese el directorio con archivos a reproducir (puede explorar con Tab): "
  	read -e dir
  	cd "$dir"
  	echo -e "\n${bold}${v} El directorio seleccionado ahora es: $(pwd)${normal}${b}"
  	sleep 2
}
menu(){
	opc=()
	echo -e "\n\t${bold}${am}SELECCIONE LA OPCION DE REPRODUCCION DE SU PREFERENCIA:${normal}${b}\n\n"
	show_opc "1)" "Reproducir una canción en el directorio seleccionado ($(pwd)).\n"
	show_opc "2)" "Reproducir todas las canciones en el directorio seleccionado\n"
	show_opc "3)" "Reproducir todas las canciones en el directorio seleccionado (ALEATORIO)\n"
	show_opc "4)" "Cambiar el directorio seleccionado\n"
	show_opc "5)" "Salir\n"
	printf "> "
	read opc
	return "$opc"
}
controles(){
	acciones=(
		"Reproducir / Pausar canción    "
		"Repetir canción                "
		"Subir volumen                  "
		"Bajar volumen                  "
		"Detener reproducción           "
		"Mostrar playlist               "
 		"Reproducir siguiente (Playlist)"
 		"Reproducir anterior (Playlist) "
 		"Reiniciar playlist             ")
	atajos=(
		"s        "
		"b        "
		"[o] + [+]"
		"[o] + [-]"
		"q        "
		"l        "
 		"f        "
 		"d        "
 		"[        ")
 	printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"
	echo -e "\n\t\t\t${bold}${t}TABLA DE CONTROLES"
	echo -e "\t${m}╔═══════════╦═════════════════════════════════╗"
   	echo -e "\t║  ${bold}${b}Atajo    ${normal}${m}║          ${bold}${b}Acción                 ${normal}${m}║"
	echo -e "\t╠═══════════╬═════════════════════════════════╣"

    	for ((indice = 0; indice < ${#atajos[@]}; indice++)); do
        	comnd="${atajos[$indice]}"
        	desc="${acciones[$indice]}"
        	echo -e "\t║ ${bold}${am}${comnd} ${normal}${m}║ ${b}${desc} ${normal}${m}║" 
    	done

    	echo -e "\t╚═══════════╩═════════════════════════════════╝${normal}${b}"
	printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"		
}
rep_cancion(){
	cancion=()
	if [ -z "$(ls *.mp3 2>/dev/null)" ]; then
		echo -e "\n${r}No se encontraron archivos .mp3 en el directorio actual.${normal}${b}"
  		sleep 2
	else
		echo -e "${bold}${m}\n”Seleccione la canción a reproducir (Explorar dir: [Tab]): ${normal}${b}"
		ls *.mp3
		echo -n "> "
		read -e cancion
		controles
		mpg123 -C --title -q "$cancion"
		printf "🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"
		sleep 2
	fi
}
rep_lista(){
	local opc=$1
	modo_rep=()
	if [ "$opc" -eq 1 ]; then 
		modo_rep=(-C --title -q -z ./*.mp3)
	else 
		modo_rep=(-C --title -q ./*.mp3)
	fi 
	if [ -z "$(ls *.mp3 2>/dev/null)" ]; then
  		echo -e "\n${r}No se encontraron archivos .mp3 en el directorio actual.${normal}${b}"
  		sleep 2
	else
  		echo -e "\n${t}Archivos .mp3 encontrados:${normal}${b}"
  		ls *.mp3
		controles
		mpg123 "${modo_rep[@]}"
		printf "🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦\n"
  		sleep 2
	fi
}
reproductor(){
	while true 
	do
		clear
		saludo
		menu
		salida_menu=$?
		case $salida_menu in
			1)
				rep_cancion
				;;
			2)
				rep_lista 0				
				;;
			3)
				rep_lista 1
				;;
			4)
				cambiar_dir
				;;
			5)
				cd "$dir_script"
        		clear
				exit 0
				;;
			*)
				continue
				;;
		esac
	done 
}

valida_rep
reproductor