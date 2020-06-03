FROM ajoergensen/baseimage-alpine  
MAINTAINER ajoergensen  
  
RUN \  
apk add --no-cache privoxy && \  
rm /etc/privoxy/config  
  
COPY root/ /  
  
RUN \  
chmod +x -v /etc/cont-init.d/*.sh /etc/services.d/*/run  
  
# Expose Privoxy Port  
EXPOSE 8118  

