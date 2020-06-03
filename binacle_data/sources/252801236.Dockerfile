FROM alpine:3.4  
RUN apk add --no-cache haproxy s6 dnsmasq  
  
COPY haproxy.cfg /etc/haproxy  
COPY dev.pem /etc/haproxy  
COPY s6 /etc/s6  
  
EXPOSE 80  
EXPOSE 443  
ENTRYPOINT ["/bin/s6-svscan", "/etc/s6"]  
  

