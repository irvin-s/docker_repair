FROM apsl/lamp  
MAINTAINER APSL <bcabezas@apsl.net>  
ENV drupal_version 7.34  
#user  
RUN \  
groupadd -g 501 drupal ;\  
useradd -u 501 -g 501 -d /app -s /bin/bash drupal ;\  
adduser www-data drupal  
  
# genkeys for wp key gen  
ADD genkeys.py /usr/local/bin/genkeys.py  
  
# drupal hooks file  
ADD hooks.sh /usr/local/bin/hooks.sh  
  
# Install drush, php redis  
RUN apt-get update && \  
apt-get -y install drush php5-redis && \  
apt-get clean  
  
RUN /usr/sbin/php5enmod redis  
  
# Download drupal  
RUN rm -rf /app/www && \  
mkdir /app/www && \  
cd /app/www && \  
drush dl drupal-$drupal_version && \  
mv drupal-$drupal_version/* drupal-$drupal_version/.htaccess ./ && \  
rm -R drupal-$drupal_version && \  
mkdir sites/default/files && \  
chown -R www-data:www-data /app/www/  
  
ADD settings.php.tpl /root/  
ADD apache-vhost.conf.tpl /root/  
  
ADD setup.d/drupal /etc/setup.d/90-drupal  
  

