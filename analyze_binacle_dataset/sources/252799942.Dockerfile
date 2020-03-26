FROM alpine:latest  
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm'  
### Install Application  
RUN apk upgrade --no-cache && \  
apk add --no-cache --virtual=run-deps \  
nginx \  
nginx-mod-http-headers-more && \  
rm -rf /tmp/* \  
/var/cache/apk/* \  
/var/tmp/*  
  
# Expose volumes  
VOLUME ["/www","/config","/logs"]  
  
# Expose ports  
EXPOSE 80  
EXPOSE 443  
### Running User: not used, managed by docker-entrypoint.sh  
#USER nginx  
### Start nginx  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["nginx"]  

