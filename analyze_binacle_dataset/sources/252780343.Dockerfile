FROM conyac/base:latest  
  
RUN apt-get update && apt-get -y install redis-server  
  
ADD redis.conf /etc/redis/redis.conf  
  
VOLUME ["/data"]  
  
EXPOSE 6379  
CMD ["/bin/bash", "-c", "redis-server /etc/redis/redis.conf"]  

