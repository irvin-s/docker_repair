FROM curtisbaldwinson/docker-apache2-dvhost-php5:latest  
MAINTAINER Curtis Baldwinson <curtisbaldwinson@gmail.com>  
  
# PhalconPHP Framework  
WORKDIR /tmp  
RUN git clone \--depth=1 git://github.com/phalcon/cphalcon.git && \  
cd cphalcon/build/ && \  
./install  
RUN rm -rf /tmp/*  
RUN echo "extension=phalcon.so" >> /etc/php5/conf.d/30-phalcon.ini  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

