FROM staci/base:0.1
MAINTAINER info@praqma.net

RUN apt-get update -y && apt-get -y install apache2 && apt-get clean

RUN /bin/ln -sf ../sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl 
RUN /bin/ln -sf ../mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.load /etc/apache2/mods-enabled/

RUN echo "ServerName praqma-100.intern.it-huset.dk" > /etc/apache2/conf-available/servername.conf 
RUN ln -s /etc/apache2/conf-available/servername.conf /etc/apache2/conf-enabled

COPY index.html /var/www/html/index.html
RUN a2enmod socache_shmcb && a2enmod proxy && a2enmod proxy_http && a2ensite default-ssl

COPY setup.sh /tmp/setup.sh
RUN /tmp/setup.sh

EXPOSE 443 
EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
