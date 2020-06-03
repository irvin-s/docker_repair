FROM andir/docker-nginx-hhvm  
MAINTAINER Andreas Rammhold <andreas@rammhold.de>  
  
COPY api.conf /etc/nginx/local.conf.d/api.conf  

