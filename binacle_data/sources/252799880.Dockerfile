FROM redis:alpine  
  
COPY redis.conf /usr/local/etc/redis.conf  
COPY entrypoint.sh /usr/local/bin/  
RUN chmod ugo=rx /usr/local/bin/entrypoint.sh  
ENTRYPOINT ["entrypoint.sh"]  

