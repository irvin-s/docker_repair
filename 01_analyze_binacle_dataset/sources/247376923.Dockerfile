# image to use
FROM debian:jessie

# apt-get what we need
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
  sudo \
  telnet \
  curl \
  vim \
  nano \
  net-tools \
  wget \
  apache2 \
  php5 \
  libapache2-mod-php5 \
  mysql-client \
  php5-memcached \
  php5-mysqlnd \
  php5-gd \
  php5-curl \
  php5-xdebug \
  golang-go \
  git

# use mhsendmail
RUN mkdir /opt/go && export GOPATH=/opt/go && go get github.com/mailhog/mhsendmail

# put the vhost in there
COPY ./projects/custom/template/apache2/template.apache2.vhost.conf /etc/apache2/sites-available/template.robot

# symlink to sites-enabled
RUN ln -s /etc/apache2/sites-available/template.robot /etc/apache2/sites-enabled/010-template.robot.conf

# remove default apache2 thing
RUN rm /var/www/html/index.html

# listen on port 81
COPY ./projects/custom/template/apache2/template.apache2.ports.conf /etc/apache2/ports.conf

# allow the vhost path
RUN sed -i -e 's/Directory \/var\/www\//Directory \/template/g' /etc/apache2/apache2.conf

# raise memory limit
RUN sed -i -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php5/apache2/php.ini

# add xdebug values to php.ini
COPY ./projects/custom/template/apache2/xdebug.php.ini /etc/php5/apache2/conf.d/20-xdebug.ini

# robot user things
RUN useradd -u 1000 -s /bin/bash -m robot
RUN sed -i -e 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=robot/g' /etc/apache2/envvars
RUN sed -i -e 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=robot/g' /etc/apache2/envvars

# sudo entry for robot
RUN echo "robot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# root .bashrc
RUN echo "PS1='\[\e[31m\]\u\[\e[m\]@\h:\w\$ '" >> /root/.bashrc
RUN echo "alias ll='ls -la'" >> /root/.bashrc
RUN echo "export TERM=xterm" >> /root/.bashrc

# robot .bashrc
RUN echo "PS1='\[\e[34m\]\u\[\e[m\]@\h:\w\$ '" >> /home/robot/.bashrc
RUN echo "alias ll='ls -la'" >> /home/robot/.bashrc
RUN echo "export TERM=xterm" >> /home/robot/.bashrc
RUN echo "cd /template" >> /home/robot/.bashrc

# sendmail path
RUN sed -i -e 's#;sendmail_path =#sendmail_path = \"\/opt\/go\/bin\/mhsendmail --smtp-addr=mailhog:1025\"#g' \
    /etc/php5/apache2/php.ini \
    /etc/php5/cli/php.ini

# blackfire
#RUN wget -O - https://packagecloud.io/gpg.key | apt-key add -
#RUN echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list
#RUN apt-get update && apt-get install blackfire-agent blackfire-php

# enable modrewrite
RUN a2enmod rewrite
