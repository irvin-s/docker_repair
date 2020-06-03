FROM alpine  
# Original maintainer: Johannes 'fish' Ziemke <docker@freigeist.org>  
MAINTAINER Bertrand Roussel <bertrand.roussel@cor-net.org>  
  
VOLUME [ "/data" ]  
RUN apk add --no-cache tcpdump coreutils  
  
CMD [ "-C", "1000", "-W", "100", "-v", "-w", "/data/dump" ]  
ENTRYPOINT [ "/usr/sbin/tcpdump" ]  

