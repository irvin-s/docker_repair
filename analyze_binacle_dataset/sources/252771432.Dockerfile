FROM ajoergensen/baseimage-alpine  
LABEL maintainer=ajoergensen  
  
ENV DISABLE_SYSLOG=true DISABLE_CRON=true  
  
RUN \  
apk add --no-cache nginx dockerize && \  
rm -rf /var/cache/apk/*  
  
ADD root/ /  
  
RUN \  
chmod +x -v /etc/cont-init.d/*.sh /etc/services.d/*/run  

