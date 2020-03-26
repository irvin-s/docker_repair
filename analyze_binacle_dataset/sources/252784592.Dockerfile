FROM centos:6.6  
MAINTAINER blackawa  
WORKDIR /usr/src  
ADD xdebug.ini /etc/php.d/  
RUN yum install -y \  
gcc \  
php \  
php-devel \  
php-mysql \  
php-pear  
RUN pecl install xdebug-2.2.7  
## Output logs to stdxxx  
RUN echo 'TransferLog /dev/stdout' >> /etc/httpd/conf/httpd.conf && \  
echo 'ErrorLog /dev/stderr' >> /etc/httpd/conf/httpd.conf  
  
EXPOSE 80  
CMD ["apachectl", "-D", "FOREGROUND"]  

