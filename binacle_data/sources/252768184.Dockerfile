FROM adite/apache_php  
MAINTAINER tescom <tescom@atdt01410.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get -yq install phpmyadmin  
  
ADD default-vhost.conf /etc/apache2/sites-available/000-default.conf  
ADD config-db.php /etc/phpmyadmin/config-db.php  
#ADD run.sh /run.sh  
#RUN chmod +x /run.sh  
#VOLUME ["/data"]  
#ENTRYPOINT ["/run.sh"]  

