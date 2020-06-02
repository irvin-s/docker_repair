FROM smartapps/bitbucket-pipelines-php-mysql  
MAINTAINER Milos Jovanov <djavolak@mail.ru>  
ENV TZ=Europe/Belgrade  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
RUN apt-get update  
RUN apt-get install --yes php5-fpm  
RUN apt-get install --yes memcached  
RUN apt-get install --yes php-pear  
RUN apt-get install --yes redis-server  
RUN apt-get install --yes php5-dev  
RUN apt-get install --yes php5-apcu  
RUN apt-get install --yes php5-tidy  
RUN apt-get install --yes libicu-dev  
RUN apt-get install --yes php5-intl  
RUN apt-get install --yes php5-igbinary  
RUN apt-get install --yes php5-memcache  
RUN apt-get install --yes php5-xdebug  
RUN apt-get install --yes php5-redis  
RUN apt-get install --yes libpcre3-dev  
RUN apt-get install --yes git-core gcc autoconf make  
#RUN pecl install imagick  
RUN service memcached start  
RUN service redis-server start  
RUN service mysql start  
  
#RUN git clone https://github.com/phalcon/cphalcon.git -b 1.3.3  
#RUN export CFLAGS="-g3 -O1 -fno-delete-null-pointer-checks -Wall";  
#RUN cd cphalcon/build && ./install  
RUN git clone -q --depth=1 https://github.com/phalcon/cphalcon.git -b 1.3.3  
RUN export CFLAGS="-g3 -O1 -fno-delete-null-pointer-checks -Wall";  
WORKDIR /cphalcon/build  
RUN ./install  
  
RUN touch /etc/php5/cli/conf.d/30-phalcon.ini  
RUN echo "extension=phalcon.so" >> /etc/php5/cli/conf.d/30-phalcon.ini  
RUN touch /etc/php5/fpm/conf.d/30-phalcon.ini  
RUN echo "extension=phalcon.so" >> /etc/php5/fpm/conf.d/30-phalcon.ini  
RUN service php5-fpm start  
EXPOSE 9000  

