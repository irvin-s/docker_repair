FROM redis  
  
MAINTAINER Frank Fuhrmann <frank.fuhrmann@mailbox.org> \- www.bitmuncher.info  
  
RUN apt-get update && apt-get -y upgrade  
COPY config/redis.conf /usr/local/etc/redis/redis.conf  
RUN mkdir -p /var/lib/redis/6379  
RUN chown redis:redis /var/lib/redis/6379  
RUN mkdir -p /var/run/redis  
RUN chown redis:redis /var/run/redis  
RUN mkdir -p /var/log/redis  
RUN chown redis:redis /var/log/redis  
VOLUME /var/log/redis  
VOLUME /var/lib/redis/6379  
EXPOSE 6379  
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]  

