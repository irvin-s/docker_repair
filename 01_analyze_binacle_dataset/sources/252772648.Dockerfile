FROM alpine:3.3  
RUN apk add --no-cache unbound  
  
EXPOSE 53/udp  
EXPOSE 53/tcp  
  
CMD ["/usr/sbin/unbound", "-d"]  

