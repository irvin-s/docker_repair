FROM debian:latest  
  
RUN apt-get update && apt-get -y upgrade && apt-get -y install apache2 php5  
RUN a2enmod php5  
RUN a2enmod rewrite  
RUN apt-get -y install git-core  
  
RUN chmod 777 -R /var/www  
RUN cd /var/www/html/ && git clone https://github.com/Allisterr/DevOps.git  
RUN cd /var/www/html/DevOps && git add . && git pull  
  
COPY apache-conf.conf /etc/apache2/sites-enabled/000-default.conf  
  
EXPOSE 80  
CMD /usr/sbin/apache2ctl -D FOREGROUND  
  

