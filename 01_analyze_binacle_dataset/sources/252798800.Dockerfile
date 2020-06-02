FROM alpine:latest  
  
MAINTAINER Open Source Services [opensourceservices.fr]  
  
RUN apk add --update \  
transmission-daemon \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir -p /transmission/downloads \  
&& mkdir -p /transmission/incomplete \  
&& mkdir -p /etc/transmission-daemon  
  
COPY src/ .  
  
VOLUME ["/transmission/downloads"]  
VOLUME ["/transmission/incomplete"]  
  
EXPOSE 9091 51413/tcp 51413/udp  
  
ENV USERNAME admin  
ENV PASSWORD password  
  
RUN chmod +x /start-transmission.sh  
CMD ["/start-transmission.sh"]  

