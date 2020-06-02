FROM ubuntu:14.04

MAINTAINER avlidienbrunn

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y language-pack-en-base
RUN apt-get install software-properties-common python-software-properties -y
RUN LC_ALL=en_US.UTF-8  add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install apache2 -y
RUN apt-get install php5.6 php5.6-mysql php-gettext php5.6-mbstring php-mbstring libapache2-mod-php5.6 -y
RUN apt-get install nano -y
RUN apt-get install netcat -y
RUN apt-get install wget -y

ENV APP_DIR /app

WORKDIR $APP_DIR

ADD . $APP_DIR/

RUN cd $APP_DIR/

RUN mv /app/index.php /var/www/html/index.php
RUN chmod -R 755 /var/www/html/
RUN rm /var/www/html/index.html
RUN chmod +x /app/run_server_unguessable992128.sh
RUN chmod +x /app/sleep.sh

RUN mv /app/config /etc/apache2/sites-available/000-default.conf
RUN mv /app/phpconfig /etc/apache2/mods-enabled/php5.6.conf
RUN mv /app/portsconfig /etc/apache2/ports.conf


CMD /app/run_server_unguessable992128.sh

