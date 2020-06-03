FROM php:7.0-apache
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install openssh-server openssh-client lshell -y
RUN useradd -m -s /usr/bin/lshell webadmin
RUN docker-php-ext-install mysqli
#COPY ./service/index.html /var/www/html/
#COPY ./service/admin/.htaccess /var/www/html/admin/.htaccess
#COPY ./service/admin/index.php /var/www/html/admin/index.php
#COPY ./service/admin/login.php /var/www/html/admin/login.php
COPY ./apache2.conf /etc/apache2/apache2.conf
RUN echo "webadmin:webadmin" | chpasswd
EXPOSE 22
EXPOSE 80

#Start MYSQL Docker

#sudo docker run --name db-iwantix2 -e MYSQL_ROOT_PASSWORD=wow_w0w -e MYSQL_USER=iwantix2 -e MYSQL_PASSWORD=iwantix22 -e MYSQL_DATABASE=iwantix2 -v /home/ctfgame/GCTF/challs/web/iwantix2/sql.sql:/docker-entrypoint-initdb.d/sql.sql -d mysql

# Run iwantix server
#sudo docker run --name iwantix2 --link db-iwantix2 -d -p 8002:80 -p 8001:22 iwantix2

#Remember to start ssh service in iwantix2 after build.

