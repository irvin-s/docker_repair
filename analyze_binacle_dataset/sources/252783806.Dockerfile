FROM redis:alpine  
MAINTAINER bingo <bingov5@icloud.com>  
  
COPY ./conf/redis.conf /usr/local/etc/redis/redis.conf  
  
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

