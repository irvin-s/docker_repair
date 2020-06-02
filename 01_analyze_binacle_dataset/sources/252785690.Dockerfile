FROM comp2041/sh  
RUN apt-get update &&\  
apt-get install -y \--no-install-recommends apache2 net-tools &&\  
rm -rf /var/lib/apt/lists/* &&\  
rm -rf /var/www/html &&\  
a2enmod rewrite &&\  
a2enmod cgid &&\  
ln -sf /dev/stdout /var/log/apache2/access.log &&\  
ln -sf /dev/stderr /var/log/apache2/other_vhosts_access.log &&\  
ln -sf /dev/stderr /var/log/apache2/error.log  
EXPOSE 80  
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf  
ADD /entrypoint entrypoint  
ENTRYPOINT ["/entrypoint"]  

