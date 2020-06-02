FROM alpine:latest  
MAINTAINER Trevor Ferre <trevor@alloylab.com>  
  
ENV TERM xterm  
  
ENV VARNISH_MEMORY 128M  
ENV VARNISH_BACKEND_PORT 8080  
ENV VARNISH_BACKEND_ADDRESS web1  
  
EXPOSE 80  
COPY conf/start.sh /start.sh  
RUN chmod +x /start.sh  
CMD ["/start.sh"]  
  
RUN apk add --update varnish  
RUN rm -rf /var/cache/apk/*

