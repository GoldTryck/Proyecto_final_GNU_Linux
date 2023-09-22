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
# Comando: feho.


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
#                                                                  Comando                                                                  #
#                                                                                                                                           #        
#############################################################################################################################################

hora=$(grep "rtc_time" /proc/driver/rtc | awk '{print $3}')
IFS=":" read -ra time <<< "$hora"
hour=${time[0]}
min=${time[1]}
sec=${time[2]}


fecha=$(grep "rtc_date" /proc/driver/rtc | awk '{print $3}')
IFS="-" read -ra date <<< "$fecha"
year=${date[0]}
month=${date[1]}
day=${date[2]}

printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

printf "\n  🟫🟨🟨🟨 🟫🟨🟨🟨 🟫🟨  🟫🟨   🟫🟨🟨"
printf "\n  🟫🟨     🟫🟨     🟫🟨  🟫🟨 🟫🟨  🟫🟨 🟫🟨 "
printf "\n  🟫🟨🟨   🟫🟨🟨   🟫🟨🟨🟨🟨 🟫🟨  🟫🟨      "
printf "\n  🟫🟨     🟫🟨     🟫🟨  🟫🟨 🟫🟨  🟫🟨 🟫🟨 "
printf "\n  🟫🟨     🟫🟨🟨🟨 🟫🟨  🟫🟨   🟫🟨🟨        \n"

printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

echo -e "\n\t${am}Fecha y hora: "
echo -e "\n\t${r}>${v}>${t}> ${b}$day${r}/${b}$month${r}/${b}$year ${t}- ${b}$hour${r}:${b}$min${r}:${b}$sec"

printf "\n🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧🟥🟪🟦🟩🟨🟧\n"

#############################################################################################################################################
#                                                                                                                                           #
#                                                     Explicacion General                                                                   #
#                                                                                                                                           #        
#############################################################################################################################################

# hora=$(grep "rtc_time" /proc/driver/rtc | awk '{print $3}')  = Se obtiene la cadena que corresponde a la hora desde el archivo rtc.
# IFS=":" read -ra time <<< "$hora"                            = Se hace un "split" a la cadena "hora", lo que retorna un arreglo "time".
# hour=${time[0]}                                              = Se asigna a una variable el elemento del arr "time" que corresponde.
# min=${time[1]}                                               = Se asigna a una variable el elemento del arr "time" que corresponde.
# sec=${time[2]}                                               = Se asigna a una variable el elemento del arr "time" que corresponde.

# fecha=$(grep "rtc_date" /proc/driver/rtc | awk '{print $3}') = Se obtiene la cadena que corresponde a la fecha desde el archivo rtc.
# IFS="-" read -ra date <<< "$fecha"                           = Se hace un "split" a la cadena "fecha", lo que retorna un arreglo "date".
# year=${date[0]}                                              = Se asigna a una variable el elemento del arr "date" que corresponde.     
# month=${date[1]}                                             = Se asigna a una variable el elemento del arr "date" que corresponde.     
# day=${date[2]}                                               = Se asigna a una variable el elemento del arr "date" que corresponde.     

#############################################################################################################################################