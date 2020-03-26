FROM redis:3.2.11-alpine  
COPY redis.conf /usr/local/etc/redis/redis.conf  
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]  
EXPOSE 6379

