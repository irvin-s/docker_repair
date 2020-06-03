FROM alpine:latest  
  
RUN apk add --no-cache bind  
  
CMD ["/usr/sbin/named", "-u", "named", "-g"]  
  
EXPOSE 53 53/udp  
  
VOLUME ["/etc/bind"]  

