FROM alpine:latest  
RUN apk --no-cache add dnsmasq  
EXPOSE 53 53/udp 67 67/udp  
VOLUME ["/etc/dnsmasq"]  
ENTRYPOINT ["dnsmasq", "-d"]  

