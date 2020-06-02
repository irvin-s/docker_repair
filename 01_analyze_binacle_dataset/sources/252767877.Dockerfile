FROM debian:latest  
MAINTAINER fmicaux@actilis.net  
  
  
# Des variables d'environnement ?  
ENV WP_URL=http://ltb-project.org/archives/ltb-project-white-pages-0.1.tar.gz  
  
# Installation Apache + PHP + modules de PHP nécessaires  
RUN apt-get update \  
&& apt-get -y install apache2 php5-ldap php5-gd smarty3 wget \  
&& mkdir -p /var/www/html \  
&& wget -O - $WP_URL | tar xz -C /var/www/html --strip-components 1 \  
&& chown www-data:www-data /var/www/html/cache \  
&& chown www-data:www-data /var/www/html/templates_c  
  
# Données à importer (ADD, COPY,...)  
COPY entrypoint.sh /entrypoint.sh  
COPY /config.inc.template /config.inc.template  
  
# Volume ?  
# Ports ?  
EXPOSE 80  
# Définition de l'entrypoint (ou CMD pendant les tests...)  
CMD ["/entrypoint.sh"]  
  

