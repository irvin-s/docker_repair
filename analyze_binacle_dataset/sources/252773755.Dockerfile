FROM alpine:latest  
MAINTAINER Trevor Ferre <trevor@alloylab.com>  
  
ENV TERM xterm  
  
ENV MEMCACHED_MEMORY 256  
ENV MEMCACHED_MAX_CONNECTIONS 1024  
EXPOSE 11211 11211/udp  
  
COPY conf/start.sh /start.sh  
RUN chmod +x /start.sh  
CMD ["/start.sh"]  
  
RUN apk add --update memcached  
RUN rm -rf /var/cache/apk/*  
  
USER memcached

