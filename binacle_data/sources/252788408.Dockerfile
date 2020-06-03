FROM crosstime1986/docker-php55  
  
MAINTAINER Pual <crosstime1986@vip.qq.com>  
  
ADD admin /app/admin  
ADD install /app/install  
ADD usr /app/usr  
ADD var /app/var  
ADD index.php /app/index.php  
ADD install.php /app/install.php  
ADD config.inc.php /app/config.inc.php  
  
RUN mkdir -p /app/usr/uploads && chmod 0777 -R /app/usr/uploads  
  
VOLUME ['/app/usr/uploads']  
  
WORKDIR /app  
  
EXPOSE 9000  

