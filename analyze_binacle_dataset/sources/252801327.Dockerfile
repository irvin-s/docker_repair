FROM ubuntu:16.04  
ENV WORK_DIR /var/www/html  
  
RUN apt-get update -y  
  
RUN apt-get install -y \  
nginx \  
php7.0 \  
php7.0-fpm \  
php7.0-pgsql \  
php7.0-mbstring \  
php-xml  
  
ADD ./run.sh /usr/local/run.sh  
  
WORKDIR ${WORK_DIR}  
  
CMD ["sh", "/usr/local/run.sh"]

