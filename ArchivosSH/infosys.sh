#!/bin/bash
title_color="\e[1;36m"
info_color="\e[0;37m"

# Mostrar título personalizado
echo -e "\n${title_color}Información del sistema${info_color}"
# Función para mostrar información
show_info() {
    echo -e "\e[1m$1\e[0m: $2"
}

# Información del sistema
show_info "Sistema" "$(uname -s)"
show_info "Hostname" "$(hostname)"
show_info "Distribución" "$(cat /etc/os-release | grep -i '^PRETTY_NAME=' | cut -d= -f2- | tr -d '"')"
show_info "Kernel" "$(uname -r)"

# Información de la CPU
show_info "CPU" "$(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2- | xargs)"
show_info "Arquitectura" "$(uname -m)"

# Información de la memoria
show_info "Memoria total" "$(free -h --si | awk '/Mem:/ {print $2}')"
show_info "Memoria disponible" "$(free -h --si | awk '/Mem:/ {print $7}')"

# Información de la GPU (requiere instalación previa de lspci)
show_info "GPU" "$(lspci | grep -i vga | cut -d: -f3- | xargs)"

# Información de almacenamiento
show_info "Almacenamiento total" "$(df -h --total | awk '/total/ {print $2}')"
show_info "Almacenamiento disponible" "$(df -h --total | awk '/total/ {print $4}')"

# Información de la fecha y hora
show_info "Fecha y hora" "$(date "+%Y-%m-%d %H:%M:%S")"

# Información del usuario actual
show_info "Usuario" "$USER"

# Información de la red
show_info "Dirección IP" "$(ip addr show | awk '/inet / {print $2}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -n 1)"

#Información del entorno de escritorio (opcional, adaptar al entorno utilizado)
show_info "Entorno de escritorio" "$XDG_CURRENT_DESKTOP"


# Restablecer estilo al final
echo -e "\e[0m"
