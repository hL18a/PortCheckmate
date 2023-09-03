#!/bin/bash
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
lightBlueColour="\e[0;94m\033[1m"

function root() {
    if [ $EUID -ne 0 ]; then
        whiptail --title "PortCheckmate - hL18a" --msgbox "No tienes permisos de superusuario..." 8 50
        sudo su
    fi
    clear
}

function iniciolinux() {
    while [[ ! $opcion_deseada =~ ^[1-7]$ ]]; do
        clear
        echo -e  "\n"
        echo -e "${lightBlueColour} ╭━━━╮╱╱╭━━━╮╭╮╱╱╱ ╱╱╱╱╭╮ ╭━╮"
        sleep 0.10
        echo -e "${lightBlueColour} ┃╭━╮┃╱╱┃╭━╮┣╯╰╮╱ ╱╱╱╱┃┃┃╭╯┃"
        sleep 0.10
        echo -e "${lightBlueColour} ┃╰━╯┣━━┫╰━╯┣╮╭╯ ╭━━┳━━┫╰╯ ╯"
        sleep 0.10
        echo -e "${lightBlueColour} ┃╭━━┫╭╮┃╭╮╭╯┃┃ ╱┃╭━┫╭━┫╭╮┃"
        sleep 0.10
        echo -e "${lightBlueColour} ┃┃╱╱┃╰╯┃┃┃╰╮┃╰╮ ┃╰━┫╰━┫┃┃╰╮"
        sleep 0.10
        echo -e "${lightBlueColour} ╰╯╱╱╰━━┻╯╰━╯╰━╯ ╰━━┻━━┻╯╰━╯"
        sleep 0.10
        echo -e "${redColour}   PortCheckmate - hL18a\033[0m"
        echo -e "${redColour}   GitHub:${greenColour} https://github.com/hL18a${resetColour}"
        echo -e "\n  ${greenColour}[1]${yellowColour} Mirar los dispositivos conectados en la red \t "
        echo -e "\n  ${greenColour}[2]${yellowColour} Aplicar nmap a una dirección IP \t "
        echo -e "\n  ${greenColour}[3]${yellowColour} Ver los puertos abiertos de tu archivo"
        echo -e "\n  ${greenColour}[4]${yellowColour} Nmap ${blueColour}personalizable${yellowColour} \t "

        echo -e -n "\n  ${grayColour}   Elige tu opción deseada: "

        read opcion_deseada
    done
}

save_file2_users_wifi1() {

    if [[ $opcion_deseada -eq 1 ]]; then

        echo -e -n "\n${purpleColour}Quieres guardar la informacion S/N ?: ${grayColour} "
        read sino

        echo -e "${grayColour}\nEjemplo:${grayColour} 192.168.1.0/24  172.16.0.0/16  10.0.0.0/8 ${greenColour}"
        echo -e -n "\n${purpleColour}Introduce la ip del Gateway: ${grayColour} "
        read ipenrutador

        case $sino in

        [sS])
            netdiscover -r $ipenrutador -L 2>/dev/null | tee usuarios_wifi.txt      #linux
            nmap -sn $ipenrutador | tee usuarios_wifi.txt  #termux

            exit
            ;;
        [Nn])
            netdiscover -r $ipenrutador -L 2>/dev/null      #linux
            nmap -sn  $ipenrutador    #termux

            exit
            ;;
        *)
            echo "Opción inválida, por favor ingresa S o N."
            ;;
        esac
    fi
}

ip_and_ports_filtro2y3() {
    echo -e -n "\n${purpleColour}   Introduce el nombre del archivo con los resultados: ${purpleColour}"
    read archivo_resultados

    if [ -f "$archivo_resultados" ]; then
        ip_address=$(cat "$archivo_resultados" | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | sort -u)
        port_list=$(cat "$archivo_resultados" | grep -oP "\d{1,5}/open" | awk '{print $1}' FS=/ | xargs | tr ' ' ',')
        sistema_operativo=$(cat "$archivo_resultados" | grep "OS:" | awk -F 'OS: ' '{print $2}')

        echo -e "\n${yellowColour} [ + ] EXTRACTING INFORMATION ..."
        echo -e "${purpleColour}\t[ * ] Dirección IP:  ${grayColour}$ip_address${grayColour}"
        echo -e "${purpleColour}\t[ * ] Puertos abiertos:  ${grayColour}$port_list${grayColour}"
        echo -e "${purpleColour}\t[ * ] Sistema operativo:  ${grayColour}$sistema_operativo${grayColour}"
    else
        echo -e "${redColour}El archivo $archivo_resultados no existe."
    fi
}
save_file2() {

    while true; do
        echo -e -n "\n${purpleColour}   Quieres guardar toda la información? S/N: ${grayColour} "
        read sino
        case $sino in
            [Ss])
                echo -e -n "\n${purpleColour}Introduce el nombre del archivo para guardar los resultados: ${grayColour}"
                read archivo_guardar

                nmap $ip -p- --open -T5 -v -n -oG $archivo_guardar 2>/dev/null   #termux
                nmap $ip -p- --open -T5 -v -n -O -oG $archivo_guardar 2>/dev/null   #linux

                ip_and_ports_filtro2y3
                exit
                ;;
            [Nn])

                nmap $ip -p- --open -T5 -v -n -oG $archivo_guardar 2>/dev/null   #termux
                nmap $ip -p- --open -T5 -v -n -O -oG allPort 2>/dev/null  #linux

                ip_address=$(cat "allPort" | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | sort -u)
                port_list=$(cat "allPort" | grep -oP "\d{1,5}/open" | awk '{print $1}' FS=/ | xargs | tr ' ' ',')
                sistema_operativo=$(cat "allPort" | grep "OS:" | awk -F 'OS: ' '{print $2}')

                echo -e "\n${yellowColour} [ + ] EXTRACTING INFORMATION ..."
                echo -e "${purpleColour}\t[ * ] Dirección IP:  ${grayColour}$ip_address${grayColour}"
                echo -e "${purpleColour}\t[ * ] Puertos abiertos:  ${grayColour}$port_list${grayColour}"
                echo -e "${purpleColour}\t[ * ] Sistema operativo:  ${grayColour}$sistema_operativo${grayColour}"

                rm allPort
                exit
                ;;
            *)
                echo "Opción inválida, por favor ingresa S o N."
                ;;
        esac
    done
}

opciones_nmap4() {
    clear
    echo -e "${greenColour} \n -F:${lightBlueColour} Escaneo rápido de los puertos más comunes."
    echo -e "${greenColour} --open:${lightBlueColour} Muestra solo los puertos abiertos."
    echo -e "${greenColour} -T5:${lightBlueColour} Especifica el modo de agresión del escaneo (más rápido)."
    echo -e "${greenColour} -v:${lightBlueColour} Activa el modo detallado (verbose) para\n mostrar información a medida que se aplica Nmap."
    echo -e "${greenColour} -n:${lightBlueColour} Muestra la dirección IP del dispositivo en lugar del nombre del host."
    echo -e "${greenColour} -oG allPorts:${lightBlueColour} Exporta los resultados en\n formato greppable a un archivo llamado 'allPorts'."
    echo -e "${greenColour} -sC:${lightBlueColour} Ejecuta los scripts NSE predeterminados."
    echo -e "${greenColour} -sS:${lightBlueColour} Es un enfoque sigiloso para averiguar\n si los puertos de un dispositivo están abiertos o cerrados."
    echo -e "${greenColour} -sV:${lightBlueColour} Detecta la versión de los servicios."
    echo -e "${greenColour} -oN targeted:${lightBlueColour} Guarda los resultados\n en un archivo llamado 'targeted'."
    echo -e "${greenColour} --min-rate 5000:${lightBlueColour} Establece la velocidad mínima de paquetes por segundo."
    echo -e "${greenColour} -vvv:${lightBlueColour} Aumenta la cantidad de información detallada en la salida."
    echo -e "${greenColour} -Pn:${lightBlueColour} Salta la detección de ping."
    echo -e "${greenColour} -p-:${lightBlueColour} Escanea todos los puertos."
    echo -e "${greenColour} -O:${lightBlueColour} Intenta detectar el sistema\n operativo del objetivo."
    echo -e "${greenColour} --traceroute:${lightBlueColour} Muestra la ruta\n de los paquetes desde tu sistema hasta el objetivo."

    echo -e "${redColour}\nEjemplo:${greenColour} nmap -F --open -T5 -v -n -oG allPorts -sC -sS -sV -oN targeted --min-rate 5000 -vvv -Pn -p- -O --traceroute <dirección_IP>"
}

opcion1linux() {
   save_file2_users_wifi1
}

opcion2linux() {
    if [[ $opcion_deseada -eq 2 ]]; then

        echo -e -n "\n   ${purpleColour}Introduce la dirección IP: ${grayColour} "
        read ip
        if ping -c 1 $ip 2>/dev/null; then
            echo -e "${yellowColour}   FELICIDADES, TIENES CONEXIÓN\n ${grayColour}"
            save_file2
        else
            echo "   No hay conexion o la ip és incorrecta"
            exit
        fi
    fi
}

opcion3linux() {
    if [[ $opcion_deseada -eq 3 ]]; then
        echo -e -n "\n   ${grayColour}Introduce el nombre del ${purpleColour}archivo : ${grayColour} "
        read allPortsfile

        base_dir="/home/"
        archivo_encontrado=false 
        search_allPorts() {
            for file in "$1"/*; do
                if [[ -f "$file" && "$(basename "$file")" == "$allPortsfile" ]]; then
                    echo -e "   ${purpleColour}Se encontró el archivo $allPortsfile en${purpleColour}: $file"
                    archivo_encontrado=true  

                elif [[ -d "$file" ]]; then
                    search_allPorts "$file"
                fi
            done
        }

        search_allPorts "$base_dir"

        if [[ $archivo_encontrado == false ]]; then
            echo "   no existe"
            exit
        else
            echo "   Búsqueda completa."
            ip_and_ports_filtro2y3 
            exit
        fi
    fi
}

opcion4linux() {
    if [[ $opcion_deseada -eq 4 ]]; then
        opciones_nmap4

        echo -e -n "\n${purpleColour}Escribe el tipo de nmap que quieres hacer : ${grayColour} "
        read tipo_nmap

        $tipo_nmap
        exit
    fi
}

function mainlinux() {
    echo -e "\t  Has elegido Linux."
    sleep 1

    root
    iniciolinux
    opcion1linux
    opcion2linux
    opcion3linux
    opcion4linx
}


termuxallport () {
    if [[ $opcion_deseada -eq 3 ]]; then
        echo -e -n "\n ${grayColour}Introduce el nombre de ${purpleColour}fichero: ${grayColour} "
        read allPortsfile

        ip_address=$(cat $allPortsfile | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | sort -u)
        ports=$(cat $allPortsfile | grep -oP "\d{1,5}/open" | awk '{print $1}' FS=/ | xargs | tr ' ' ',')

        echo -e "\n${yellowColour}[ + ] EXTRAYENDO INFORMACIÓN ..."
        echo -e "${purpleColour}\t[ * ] Dirección IP:\t${grayColour}$ip_address${grayColour}"
        echo -e "${purpleColour}\t[ * ] Puertos abiertos:\t${grayColour}$ports${grayColour}"
        exit
    fi

}
while true; do
    clear
    echo -e "${purpleColour}\t[ 1 ] Linux:${grayColour}"
    echo -e  "${purpleColour}\t[ 2 ] Termux:${grayColour}\n"
    echo -e -n "${redColour}\t  Elige una opción:${grayColour}"

    read sistema

    if [[ $sistema -eq 1 ]]; then
        mainlinux

    elif [[ $sistema -eq 2 ]]; then
        echo -e "\t  Has elegido Termux."
        sleep 1
        iniciolinux
        opcion1linux
        opcion2linux
        termuxallport
        opcion4linux
    else
        echo -e "${redColour}\t  Opción no válida. Por favor, elige 1 o 2.${endColour}"
    fi
done
