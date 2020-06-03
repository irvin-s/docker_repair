FROM redis:3.2.0-alpine  
MAINTAINER Brandon Papworth <brandon@papworth.me>  
  
COPY artifacts/redis.conf /usr/local/etc/redis/redis.conf  
  
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]  

