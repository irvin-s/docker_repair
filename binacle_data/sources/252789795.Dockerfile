FROM dylanlindgren/docker-phpcli:latest  
  
MAINTAINER "Dylan Miles" <dylan.g.miles@gmail.com>  
  
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
php5-tidy  
  
RUN mkdir -p /data  
VOLUME ["/data"]  
WORKDIR /data/web  
  
ENTRYPOINT ["php", "artisan"]  
CMD ["--help"]  

