FROM alpine:latest  
  
RUN apk add --no-cache samba-server  
  
CMD ["/usr/sbin/nmbd", "--foreground", "--log-stdout"]  
  
EXPOSE 137/udp 138/udp  
  
VOLUME ["/etc/samba"]  

