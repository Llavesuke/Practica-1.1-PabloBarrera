#!/bin/bash

# Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Instalar Apache
sudo apt install apache2 -y

# Iniciar y habilitar Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Instalar MySQL
sudo apt install mysql-server -y

# Asegurar la instalación de MySQL
sudo mysql_secure_installation

# Instalar PHP y extensiones necesarias
sudo apt install php libapache2-mod-php php-mysql php-cli -y

# Reiniciar Apache para cargar PHP
sudo systemctl restart apache2

echo "Pila LAMP instalada correctamente."
