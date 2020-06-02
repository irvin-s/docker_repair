FROM dylanlindgren/docker-phpcli:latest  
  
MAINTAINER "Dmitry Momot" <mail@dmomot.com>  
  
WORKDIR /tmp  
  
RUN apt-get update -y && \  
apt-get install -y \  
php5-curl \  
php5-mcrypt \  
php5-mongo \  
php5-mssql \  
php5-mysqlnd \  
php5-pgsql \  
php5-redis \  
php5-sqlite \  
php5-gd \  
php5-memcached \  
php5-memcache  
  
RUN mkdir -p /data/www  
VOLUME ["/data"]  
WORKDIR /data/www  
  
ENTRYPOINT ["php", "artisan"]  
CMD ["--help"]  

