FROM        flat
MAINTAINER	Daniel von Rhein <daniel.vonrhein@mpi.nl>

#Build xdebug library
RUN apt-get update &&\
    apt-get -y dist-upgrade &&\
    apt-get -y install php-pear &&\
    apt-get -y install php7.0-dev  &&\
    apt-get install net-tools &&\
    pecl install xdebug &&\
    pear install PHP_CodeSniffer

#Add xdebug configuration to php.ini
COPY xdebug/xdebug.conf /tmp/
RUN cat /tmp/xdebug.conf > /etc/php/7.0/apache2/conf.d/xdebug.ini

#Add SSH root-account to docker image
RUN echo 'root:root' | chpasswd  &&\
	sed -i '/#PermitRootLogin/s/^#//g' /etc/ssh/sshd_config &&\
	sed -e 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# add devel and admin modules

COPY drush/Create_test_user.php /tmp/Create_test_user.php

RUN cd /var/www/html/flat/ &&\
    export PGPASSWORD=fedora &&\
    service supervisor start &&\
    /wait-postgres.sh &&\
    supervisorctl start tomcat &&\
    /wait-tomcat.sh &&\
    /var/www/composer/vendor/drush/drush/drush dl admin_menu -y &&\
    /var/www/composer/vendor/drush/drush/drush -y dl devel  &&\
    /var/www/composer/vendor/drush/drush/drush -y dl feeds  &&\
    /var/www/composer/vendor/drush/drush/drush en -y admin_menu &&\
    /var/www/composer/vendor/drush/drush/drush -y en devel  &&\
#    /var/www/composer/vendor/drush/drush/drush -y en feeds  &&\
#    /var/www/composer/vendor/drush/drush/drush -y en feeds_ui  &&\
#    /var/www/composer/vendor/drush/drush/drush php-script Create_test_user.php --script-path=/tmp &&\

    supervisorctl stop all &&\
    service supervisor stop &&\
    sleep 1

#RUN mv /app/flat/lib/doorkeeper.jar /app/flat/lib/doorkeeper.jar.bkp &&\
#    mv  /app/flat/deposit/flat-deposit.xml /app/flat/deposit/flat-deposit.xml.bkp

#EXPOSE 5005

#Clean up when done.
RUN apt-get clean



