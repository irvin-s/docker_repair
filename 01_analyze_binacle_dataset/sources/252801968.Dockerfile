FROM debian:jessie  
  
MAINTAINER michimau <mauro.michielon@eea.europa.eu>  
  
RUN apt-get -y update  
RUN apt-get -y install apache2 vim postgresql-client php5-pgsql php5  
  
COPY pear.tar /  
COPY smarty.tar /  
  
RUN cd / && tar xvf /pear.tar && tar xvf smarty.tar  
  
RUN a2enmod rewrite  
  
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf  
  
EXPOSE 80  
CMD ["apache2ctl", "-D", "FOREGROUND"]  

