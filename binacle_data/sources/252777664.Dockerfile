FROM ubuntu:16.04  
MAINTAINER antiline <antiline@jun2.org>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
apache2 \  
software-properties-common \  
supervisor \  
&& apt-get clean \  
&& rm -fr /var/lib/apt/lists/*  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
libapache2-mod-php7.0 \  
php7.0 \  
php7.0-zip \  
&& apt-get clean \  
&& rm -fr /var/lib/apt/lists/*  
  
RUN a2enmod rewrite  
  
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
COPY conf/run.sh /run.sh  
RUN chmod 755 /run.sh  
  
RUN mkdir -p /volume1/manga/  
RUN mkdir -p /var/services/web/comix-server/  
ADD src/* /var/services/web/comix-server/  
ADD conf/httpd.conf-comix /etc/apache2/sites-enabled/aircomix_vhost.conf  
  
EXPOSE 31257  
VOLUME /volume1/manga  
  
CMD ["/run.sh"]

