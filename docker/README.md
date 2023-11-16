# Создание новой ветки и установка инструмента для анализа Docker-файла
git checkout -b hw-14
wget https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
sudo mv hadolint-Linux-x86_64 /usr/local/bin/hadolint
sudo chmod +x /usr/local/bin/hadolint

# Создание директории docker и редактирование Dockerfile
mkdir docker
cd docker/
vim Dockerfile
hadolint Dockerfile
gh repo clone saaverdo/flask-alb-app

# Сборка Docker-образа для Flask-приложения
docker build -t flask-app -f docker/Dockerfile .

# Установка Docker и сборка образа Flask-приложения 
sudo snap install docker
docker build -t flask-app -f docker/Dockerfile .

# Запуск Flask-приложения в контейнере на порту 8000
sudo docker run -p 8000:8000 flask-app

# Сборка Docker-образа для Flask-приложения
docker build -t flask-app -f docker/Dockerfile .

# Запуск контейнера с MariaDB
docker run -d --rm --name mariadb -p 127.0.0.1:3306:3306 -e MARIADB_ROOT_PASSWORD=superpass mariadb

# Запуск контейнера MariaDB з монтуванням тома та назначенням мережевого аліасу
docker run -d --rm --name mariadb -p 127.0.0.1:3306:3306 \
  -e MARIADB_ROOT_PASSWORD=superpass \
  -v db_vol:/var/lib/mysql \
  --network-alias=db_server \
  mariadb

# Підключення до контейнера MariaDB
docker exec -it mariadb bash

# Виконання команд створення користувача та бази даних в MariaDB
mariadb -uroot -psuperpass -e "CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'Pa55WD'; \
  SELECT user FROM mysql.user; \
  CREATE DATABASE IF NOT EXISTS flask_db; \
  GRANT ALL ON flask_db.* TO 'admin'@'%'; \
  SHOW DATABASES;"

# Вихід з контейнера MariaDB
exit

# Запуск Flask-приложения в контейнере и связь с MariaDB
sudo docker run -d --rm --name app -p 8000:8000 --link mariadb:db_server flask-app

# Вывод логов Flask-приложения
sudo docker logs app
sudo docker login -u prostalm
sudo docker tag flask-app:latest prostalm/flask-app:1.0
# Пуш Flask-приложения 
sudo docker push prostalm/flask-app:1.0
