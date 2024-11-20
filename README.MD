# Instalación Automatizada de la Pila LAMP en Ubuntu Server


### 1. Instalación de Apache HTTP Server, PHP, y MySQL Server

La pila LAMP (Linux, Apache, MySQL, PHP) permite configurar un servidor web básico en Linux con soporte para aplicaciones web dinámicas. Para instalar cada componente en Ubuntu, seguimos estos pasos:

1. **Actualizar el sistema** :

```bash
sudo apt update && sudo apt upgrade -y
```

2. **Instalar Apache** :

```bash
sudo apt install apache2 -y
```

* Verificar la instalación accediendo a `http://localhost` o a la IP del servidor. Debe mostrarse la página de bienvenida de Apache.

3. **Instalar MySQL** :

```bash
sudo apt install mysql-server -y
```

* Asegurar MySQL con el script de configuración:
  * ```
    sudo mysql_secure_installation
    ```

4. **Instalar PHP** :

```bash
sudo apt install php libapache2-mod-php php-mysql -y
```

* Crear un archivo `index.php` en `/var/www/html/` con el siguiente contenido para probar PHP:

  ```php
  <?php
  phpinfo();
  ?>
  ```
* Acceder a `http://localhost/index.php` para comprobar la información de PHP.

---

### 2. Instalación de phpMyAdmin

phpMyAdmin proporciona una interfaz gráfica para gestionar bases de datos MySQL.

1. **Instalar phpMyAdmin** :

```bash
sudo apt install phpmyadmin -y
```

2. **Configurar Apache para phpMyAdmin** :

* Incluye phpMyAdmin en el archivo de configuración de Apache o crea un enlace simbólico:
  ```bash
  sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
  ```


### 3. Instalación de Adminer

Adminer es una herramienta alternativa a phpMyAdmin para administrar bases de datos MySQL.

1. **Descargar Adminer** :

```bash
sudo mkdir /var/www/html/adminer
sudo wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/adminer/index.php
```

2. **Acceder a Adminer** en `http://localhost/adminer` e iniciar sesión.

### 4. Instalación del Analizador de Logs GoAccess

GoAccess permite visualizar estadísticas en tiempo real de los logs de Apache.

1. **Instalar GoAccess** :

```
sudo apt install goaccess -y
```

2. **Ejecutar GoAccess** para generar informes de logs en HTML:

```bash
sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html &
```

---

### 5. Control de Acceso a un Directorio con .htaccess

Para proteger el directorio de estadísticas con usuario y contraseña, configuramos un archivo `.htaccess`.

1. **Crear el archivo de contraseñas** :

```bash
sudo htpasswd -c /etc/apache2/.htpasswd usuario
```

2. **Crear el archivo .htaccess** en `/var/www/html/stats/`:

```plaintext
AuthType Basic
AuthName "Acceso restringido"
AuthUserFile "/etc/apache2/.htpasswd"
Require valid-user
```

3. **Configurar Apache para usar .htaccess** :

* Editar el archivo de configuración de Apache `/etc/apache2/sites-available/000-default.conf` y agregar:
  ```plaintext
  <Directory "/var/www/html/stats">
      AllowOverride All
  </Directory>

  ```

4. **Reiniciar Apache** :
   ```bash
   sudo systemctl restart apache2
   ```

5. **Acceder a las estadísticas** en `http://localhost/stats/`, donde se solicitará autenticación.
