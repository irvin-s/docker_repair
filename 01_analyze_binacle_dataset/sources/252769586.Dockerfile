FROM redis:3  
MAINTAINER huangli <areyouok@gmail.com>  
  
COPY docker-sentinel-entrypoint.sh /usr/local/bin/  
COPY sentinel1.conf /etc/sentinel1.conf  
COPY sentinel2.conf /etc/sentinel2.conf  
COPY sentinel3.conf /etc/sentinel3.conf  
RUN chmod +x /usr/local/bin/docker-sentinel-entrypoint.sh  
ENTRYPOINT ["docker-sentinel-entrypoint.sh"]  
  
EXPOSE 6379 6380 6381 26379 26380 26381  

