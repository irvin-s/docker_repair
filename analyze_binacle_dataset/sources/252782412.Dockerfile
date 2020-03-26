FROM alpine  
MAINTAINER swisstengu <tengu@tengu.ch>  
  
RUN apk add --no-cache sed bash run-parts curl  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
COPY docker-entrypoint.d/* /docker-entrypoint.d/  
RUN chmod -R +x /docker-entrypoint.sh /docker-entrypoint.d/*  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
VOLUME ["/etc/nginx/conf.d/"]  

