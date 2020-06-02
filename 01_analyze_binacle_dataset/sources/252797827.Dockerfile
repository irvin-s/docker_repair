FROM busybox  
# because of https://github.com/docker/compose/issues/3082  
MAINTAINER cocuh <cocuh.kk at gmail.com>  
  
RUN mkdir -p /var/www/years  
COPY data /var/www/years  

