FROM cloudposse/apache-php  
  
MAINTAINER Erik Osterman "e@osterman.com"  
ENV APACHE_EVENT_START_SERVERS 2  
ENV APACHE_EVENT_MIN_SPARE_THREADS 25  
ENV APACHE_EVENT_MAX_SPARE_THREADS 75  
ENV APACHE_EVENT_THREAD_LIMIT 64  
ENV APACHE_EVENT_THREADS_PER_CHILD 25  
ENV APACHE_EVENT_MAX_REQUEST_WORKERS 150  
ENV APACHE_EVENT_MAX_CONNECTIONS_PER_CHILD 0  
ENV PHP_FPM_PM ondemand  
ENV PHP_FPM_MAX_CHILDREN 10  
ENV PHP_FPM_START_SERVERS 1  
ENV PHP_FPM_SPARE_SERVERS 1  
ENV PHP_FPM_MAX_SPARE_SERVERS 10  
ENV PHP_FPM_PROCESS_IDLE_TIMEOUT 25s  
ENV PHP_FPM_MAX_REQUESTS 500  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
apt-add-repository multiverse && \  
apt-get update && \  
apt-get -y install \  
apache2-mpm-event \  
libapache2-mod-fastcgi \  
php5-fpm && \  
apt-get clean && \  
rm -f /var/www/html/index.html && \  
echo '<?php // silence is golden ?>' > /var/www/html/index.php  
  
ADD conf-available/ /etc/apache2/conf-available/  
ADD mods-available/ /etc/apache2/mods-available/  
ADD fpm/ /etc/php5/fpm/  
ADD start /start  
  
RUN a2dismod mpm_prefork && \  
a2dismod mpm_worker && \  
a2dismod php5 && \  
a2enmod mpm_event && \  
a2enmod actions && \  
a2enmod fastcgi && \  
a2enmod alias && \  
a2enconf php5-fpm  
  

