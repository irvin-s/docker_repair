FROM apsl/lamp  
MAINTAINER APSL <bcabezas@apsl.net>  
  
#user  
RUN \  
groupadd -g 501 wordpress ;\  
useradd -u 501 -g 501 -d /app -s /bin/bash wordpress ;\  
adduser www-data wordpress  
  
# genkeys for wp key gen  
ADD genkeys.py /usr/local/bin/genkeys.py  
  
# wordpress latest  
ADD http://wordpress.org/latest.tar.gz /wordpress.tar.gz  
RUN \  
tar xvzf /wordpress.tar.gz && \  
rm -rf /app/www && \  
mv /wordpress /app/www && \  
chown -R www-data:www-data /app/www/  
  
ADD wp-config.php.tpl /root/  
ADD apache-vhost.conf.tpl /root/  
  
ADD setup.d/wordpress /etc/setup.d/90-wordpress  
  

