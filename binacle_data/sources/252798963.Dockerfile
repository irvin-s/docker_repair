FROM redis:alpine  
  
LABEL maintainer="Devil.Ster.1"  
LABEL version="1.0"  
  
RUN mkdir /etc/redis  
COPY config/redis.conf /etc/redis/redis.conf  
RUN chown -R redis:redis /etc/redis  
  
VOLUME /data  
WORKDIR /data  
  
ENTRYPOINT redis-server /etc/redis/redis.conf; sh  
  
EXPOSE 6379  

