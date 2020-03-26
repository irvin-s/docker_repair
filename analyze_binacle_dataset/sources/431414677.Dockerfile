FROM ubuntu:12.04

RUN apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl  

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql php-apc php5-gd php5-curl php5-memcache memcached drush mc
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean

RUN easy_install supervisor
ADD ./initiate.sh /initiate.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./deployment.drushrc.php ~/.drush/deployment.drushrc.php

# Retrieve drupal
RUN rm -rf /var/www/ ; cd /var ;
RUN git clone https://github.com/fusionx1/x-team-drush1.git /var/drupal
RUN mv /var/drupal/ /var/www/
RUN cd /var/www ; drush dl drush_deployment ;
RUN chmod a+w /var/www/sites/default ; mkdir /var/www/sites/default/files ; chown -R www-data:www-data /var/www/
RUN chmod 755 /initiate.sh /etc/apache2/foreground.sh
EXPOSE 80
CMD ["/bin/bash", "/initiate.sh"]

