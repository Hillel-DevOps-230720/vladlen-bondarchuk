#!/bin/bash

MYSQL_USER="admin"
MYSQL_PASSWORD="Pa55WD"
MYSQL_DB="flask_db"

# Обновляем список доступных пакетов
sudo yum update -y

# Установка MariaDB Server
sudo yum install -y mariadb105-server

# Запуск MariaDB и включение автозапуска при загрузке
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl restart mysql



# Создаем пользователя и базу данных MySQL
sudo mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
USE mysql;
SELECT user FROM user WHERE user = '$MYSQL_USER';
CREATE DATABASE IF NOT EXISTS $MYSQL_DB;
GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;"

# Проверяем список доступных баз данных
sudo mysql -e "SHOW DATABASES;"

# Устанавливаем дополнительные пакеты
sudo yum install -y python3-pip 

# Очищаем кэш пакетов и освобождаем дисковое пространство (необязательно)
sudo yum clean all



