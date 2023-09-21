#!/bin/bash
#############################################################################################################################################
#                                                                                                                                           #
#                                                     Explicación del archivo                                                               #
#                                                                                                                                           #        
#############################################################################################################################################


# ESte archivo verifica si el usuario existe en el Sistema Operativo y valida sus credencailes para dar acceso a las utilidades.
#
# Integrantes del equipo:
#       - Balam Flores Gabriel Patricio
#       - Larios Ponce Hector Manuel
#
# Comando: login.

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
#                                                               Implementación                                                              #
#                                                                                                                                           #
#############################################################################################################################################

echo -ne "${az}Ingrese su nombre de usuario: ${bold}${am}"
read usuario

echo
#Buscar si el usuario esta registrado en el archivo passwd que contine datos sobre las cuentas de usuario en el SO
if grep -q "^$usuario:" /etc/passwd; then 
    echo -ne "${normal}${az}Ingrese su contraseña: ${b}"
    read -s passwd

    #Intentar verificar las credenciales usando el comando sudo redirige la salida para que no se muestre en pantalla
	if su "$usuario" -c "true" -s /bin/bash <<< "$passwd" >/dev/null 2>&1; then

        #Verificacion exitosa:
		exit 0
	else
    #Contraeña incorrecta:
	echo -e "${bold}${r}Bad pass. You're out.${normal}${b}"
		exit 1
	fi
else

    #Usuario no encontrado:
    echo -e "${r}Usuario no encontrado. You're out.${b}"
    exit 1
fi
