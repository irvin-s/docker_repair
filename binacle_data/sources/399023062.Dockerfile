FROM ubuntu
MAINTAINER Кривошлыков Евгений <docker@mpak.su>

RUN apt-get update && apt-get -y upgrade
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y vim
RUN apt install -y wget

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install -y apache2
RUN apt install -y php7.0
RUN apt install -y php7.2-mysql
RUN apt install -y libapache2-mod-php7.2
RUN apt install -y curl
RUN apt install -y php-mbstring
RUN apt install -y php-mysql
RUN apt install -y php7.2-sqlite
RUN apt install -y php-gd
RUN apt install -y php-intl
RUN apt install -y php-xml
RUN apt install -y php-curl

#RUN apt install -y php7.0-ffmpeg

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.2/apache2/php.ini
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.2/cli/php.ini

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN echo "IncludeOptional /var/www/*.conf" >> /etc/apache2/apache2.conf
#RUN sed -i "s/<\/VirtualHost>/Проверка\n<\/VirtualHost>" /etc/apache2/apache2.conf
RUN sed -i "s/<\/VirtualHost>/\n\t<Directory \/var\/www\/html>\n\t<\/Directory>\n<\/VirtualHost>/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<\/Directory>/\tOptions Indexes FollowSymLinks MultiViews\n\t<\/Directory>/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<\/Directory>/\tAllowOverride All\n\t<\/Directory>/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<\/Directory>/\tOrder allow,deny\n\t<\/Directory>/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<\/Directory>/\tAllow from all\n\t<\/Directory>/g" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<\/Directory>/\tRequire all granted\n\t<\/Directory>/g" /etc/apache2/sites-available/000-default.conf
RUN mv /etc/apache2/sites-enabled/000-default.conf /tmp
RUN cd /etc/apache2/sites-enabled/; ln -s ../sites-available/000-default.conf 000-default.conf
RUN a2enmod php7.2
RUN a2enmod rewrite
#RUM apt install -y certbot
#RUN a2enmod python-certbot-apache
#RUN a2enmod ssl
EXPOSE 80
EXPOSE 22

#        <Directory /var/www/html>
#                Options Indexes FollowSymLinks MultiViews
#                AllowOverride All
#                Order allow,deny
#                Allow from all
#                Require all granted
#        </Directory>

RUN wget -O /var/www/html/index.phar https://github.com/mpak2/mpak.su/raw/master/phar/index.phar
RUN wget -O /var/www/html/.htaccess https://github.com/mpak2/mpak.su/raw/master/.htaccess
RUN wget -O /var/www/html/.htdb https://github.com/mpak2/mpak.su/raw/master/.htdb
RUN chown www-data /var/www/html/.htdb
RUN chown www-data /var/www/html
RUN mkdir /var/www/html/include
RUN mkdir /var/www/html/include/images
RUN chmod 0777 /var/www/html/include/images
RUN rm /var/www/html/index.html

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
#RUN echo 'root:'`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1` | chpasswd
RUN echo 'root:mypassword' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN apt-get clean

CMD /usr/sbin/sshd -D

#CMD apachectl -D FOREGROUND
#CMD ["/etc/init.d/apache2", "start"]

