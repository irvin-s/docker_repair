FROM docker.1024.lu/1024/apache-php:latest  
MAINTAINER Martin Simon <martin@tentwentyfour.lu>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y php5-curl php5-xdebug \  
mysql-client php5-intl libxrender1 libxext6  
RUN apt-get install -y libxrender-dev libxext-dev  
RUN a2enmod rewrite  
  
ADD app.conf /etc/apache2/sites-available/  
RUN a2dissite 000-default.conf  
RUN a2ensite app.conf  
  
RUN apt-get clean && \  
apt-get autoclean && \  
apt-get autoremove && \  
rm -rf /var/lib/{apt,dpkg,cache,log}/  

