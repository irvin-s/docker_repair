FROM alpine:latest  
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm'  
### Install Application  
RUN apk upgrade --no-cache && \  
apk add --no-cache --virtual=run-deps \  
fetchmail ca-certificates procmail msmtp su-exec && \  
rm -rf /tmp/* \  
/var/cache/apk/* \  
/var/tmp/*  
  
# Expose volumes  
VOLUME ["/config", "/config/logs"]  
  
# Expose ports  
#EXPOSE 25  
### Running User: not used, managed by docker-entrypoint.sh  
#USER fetchmail  
### Start fetchmail  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["fetchmail"]  

