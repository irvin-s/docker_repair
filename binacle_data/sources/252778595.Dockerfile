FROM brzdigital/ubuntu  
  
MAINTAINER "Joao Paulo Barbosa" <jpaulobneto@gmail.com>  
  
WORKDIR /tmp  
  
RUN apt-get update -y  
RUN apt-get install -y \  
php7.2-cli \  
php7.2-mongo \  
php7.2-mysqlnd \  
php7.2-pgsql \  
php7.2-redis \  
php7.2-sqlite \  
php7.2-gd \  
&& rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/var/www"]  
WORKDIR /var/www  
  
ENTRYPOINT ["php", "artisan"]  
CMD ["--help"]  

