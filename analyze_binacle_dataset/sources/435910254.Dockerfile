FROM ubuntu:latest

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

ENV APP_DIR /app

WORKDIR $APP_DIR

ADD . $APP_DIR/

RUN cd $APP_DIR/

# RUN useradd -c 'jail user' -m -d /home/jailer -s /bin/bash jailer
RUN mv /app/* /var/www/html/
RUN rm /var/www/html/Dockerfile
RUN chmod -R 755 /var/www/html/
RUN rm /var/www/html/index.html
RUN chmod +x /var/www/html/run_server_unguessable9321128.sh

RUN mv /var/www/html/config /etc/apache2/sites-available/000-default.conf
RUN mv /var/www/html/phpconfig /etc/apache2/mods-enabled/php5.6.conf

# RUN php5enmod mysqli

# RUN php /var/www/install_fulhack_i_am_a_sinner.php

# USER jailer

CMD /var/www/html/run_server_unguessable9321128.sh