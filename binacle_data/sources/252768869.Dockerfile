FROM debian:jessie  
  
  
MAINTAINER "SpiralOut" <spiralout.eu@gmail.com>  
  
WORKDIR /tmp  
  
RUN apt-get update -y && \  
apt-get install -y \  
php5-cli \  
php5-curl \  
php5-mcrypt \  
php5-mongo \  
php5-mssql \  
php5-mysqlnd \  
php5-pgsql \  
php5-redis \  
php5-sqlite \  
php5-mongo \  
php5-gd && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /var/www  
VOLUME ["/var/www"]  
WORKDIR /var/www  
  
EXPOSE 3306  
ENTRYPOINT ["php", "artisan"]  
CMD ["--help"]  
  

