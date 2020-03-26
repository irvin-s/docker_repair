FROM alpine:latest  
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm'  
### Install Application  
RUN apk upgrade --no-cache && \  
apk add --no-cache --virtual=run-deps \  
su-exec \  
ssmtp \  
mailx \  
transmission-daemon && \  
rm -rf /tmp/* \  
/var/cache/apk/* \  
/var/tmp/*  
  
### Volume  
VOLUME ["/config","/downloads","/watch"]  
  
### Expose ports  
EXPOSE 9091 9092/tcp 9092/udp  
  
### Running User: not used, managed by docker-entrypoint.sh  
#USER transmission  
### Start transmission  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["transmission"]  

