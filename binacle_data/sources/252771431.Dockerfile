FROM ajoergensen/baseimage-alpine  
MAINTAINER ajoergensen  
  
RUN \  
apk add --no-cache sed unbound unbound-libs libressl && \  
mkdir /etc/unbound/unbound.conf.d && \  
chown -R unbound:unbound /etc/unbound && \  
rm -rf /var/cache/apk/* /tmp/* /var/tmp/*  
  
ADD root/ /  
  
RUN chmod -v +x /etc/services.d/*/run /etc/cont-init.d/*  
  
EXPOSE 53/udp  
EXPOSE 53  

