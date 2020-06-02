From ajoergensen/baseimage-alpine  
  
RUN \  
apk -U upgrade && \  
apk add socat && \  
rm -rf /var/cache/apk/*  
  
COPY root /  
  
RUN \  
chmod +x -v /etc/services.d/*/run  

