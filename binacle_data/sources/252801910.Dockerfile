  
#FROM richarvey/nginx-php-fpm:latest  
FROM eboraas/apache-php:latest  
MAINTAINER Markus Dahinden  
LABEL multi.label1="gdi_website"  
  
# add test PHP file  
#RUN mkdir /usr/share/html  
#RUN chown -Rf nginx:nginx /usr/share/html/  
#RUN mkdir /usr/share/html  
#VOLUME /var/www/html/  
RUN a2enmod rewrite  
RUN apt-get update -y  
RUN apt-get install apt-utils -y  
RUN apt-get install php5-curl -y  
RUN ln -sf /dev/stdout /var/log/apache2/access.log  
RUN ln -sf /dev/stderr /var/log/apache2/error.log  
  
#EXPOSE 80  
#COPY . /usr/share/html  
#RUN rm /usr/share/html/nginx.conf  
#RUN rm /usr/share/html/Dockerfile  
#ADD nginx.conf /etc/nginx/sites-available/default.conf  
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf  

