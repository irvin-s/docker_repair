FROM nginx  
MAINTAINER beilber brian.eilber@gmail.com  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y \  
php5-fpm \  
php5-cli \  
php5-mcrypt \  
php5-curl \  
php5-pgsql \  
php5-apcu \  
php5-gd \  
git \  
curl \  
vim  
  
RUN curl -sS https://getcomposer.org/installer | php  
  
RUN mv composer.phar /usr/local/bin/composer  
  
RUN git clone https://github.com/TechnicPack/TechnicSolder.git /TechnicSolder  
  
RUN cd /TechnicSolder && composer install --no-dev --no-interaction  
  
COPY config/solder.php /TechnicSolder/app/config/solder.php  
COPY config/app.php /TechnicSolder/app/config/app.php  
COPY config/database.php /TechnicSolder/app/config/database.php  
  
ADD ./scripts/start /start  
  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
RUN mkdir /etc/nginx/ssl  
  
ADD config/solderrepo /etc/nginx/solderrepo  
ADD config/soldercore /etc/nginx/soldercore  
  
RUN chmod +x /start  
  
EXPOSE 80  
CMD /start && nginx  

