# PortCheckmate - Herramienta de Escaneo de Red y Puertos

PortCheckmate es una herramienta de línea de comandos escrita en Bash que 
facilita la detección de dispositivos en una red y el escaneo de puertos utilizando Nmap.

## Características clave

**Detección de Dispositivos en la Red:** PortCheckmate te permite buscar y listar los 
dispositivos conectados a tu red local. Esto es útil para identificar qué dispositivos están en línea en tu red.

**Escaneo de Puertos Rápido:** La herramienta realiza un escaneo rápido de los puertos más
comunes en un dispositivo o en toda la red. Esto facilita la identificación de posibles 
servicios o vulnerabilidades expuestas en los dispositivos.

**Visualización de Puertos Abiertos:** Puedes ver fácilmente los puertos abiertos en un archivo 
de resultados previamente guardado. Esto te permite realizar un seguimiento de los cambios
en la disponibilidad de puertos con el tiempo.

**Escaneos Personalizables con Nmap:** PortCheckmate utiliza Nmap bajo el capó, lo que te
permite ejecutar escaneos personalizables. Puedes ajustar las opciones de escaneo según 
tus necesidades específicas, como realizar un escaneo más completo o específico.

## Requisitos

Para utilizar PortCheckmate, asegúrate de cumplir con los siguientes requisitos:

- **Sistema Operativo:** PortCheckmate ha sido desarrollado y probado en sistemas Linux,
 pero también es compatible con Termux, un emulador de terminal para Android. Esto significa
 que puedes usarlo tanto en sistemas Linux como en dispositivos Android que ejecuten Termux.

- **Nmap:** Debes tener Nmap instalado en tu sistema. Nmap es una herramienta de escaneo de red
 ampliamente utilizada que PortCheckmate aprovecha para realizar escaneos de puertos.
`sudo apt-get update`
`sudo apt-get install nmap`

- **Permisos de Superusuario:** Para algunas operaciones de escaneo, es posible que necesites
  permisos de superusuario. En sistemas Linux, puedes usar el comando `sudo su` para obtener estos privilegios.

## Instalación

Sigue estos pasos para instalar PortCheckmate en tu sistema:

1. Clona el repositorio:
   ```bash
   git clone https://github.com/hL18a/PortCheckmate.git
   cd PortCheckmate
   chmod +x Portcck.sh
   ./Portcck.sh
   
# Responsabilidad y Uso Ético
El autor de este software no asume ninguna responsabilidad por el uso indebido del 
software o cualquier daño que pueda resultar del uso de este software. El usuario es el único 
responsable de su uso y debe utilizarlo de manera ética y legal.

El autor de este software no será responsable de ninguna pérdida, daño o consecuencia que resulte del uso de este software.
Por favor, utilice este software con responsabilidad y de acuerdo con las leyes y regulaciones aplicables en su jurisdicción.


