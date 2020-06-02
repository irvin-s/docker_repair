FROM danlucas/laravel-docker-base:0.1.0  
  
MAINTAINER "Daniel Lucas" <daniel.chris.lucas@gmail.com>  
  
USER root  
  
WORKDIR /tmp  
  
RUN apt-get update -y && \  
apt-get install -y \  
curl \  
php5-cli \  
php5-curl \  
php5-gd \  
php5-mcrypt \  
php5-mysqlnd \  
php5-pgsql \  
php5-sqlite  
  
RUN mkdir -p /data/www  
VOLUME ["/data"]  
WORKDIR /data/www  
  
USER developer  
  
ENTRYPOINT ["php", "artisan"]  
CMD ["--help"]  

