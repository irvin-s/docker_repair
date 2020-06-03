FROM alpine  
  
MAINTAINER mamelnikov@spb.rpkb.ru  
  
RUN apk update && \  
apk add bash  
  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]

