FROM gliderlabs/alpine:3.1  
RUN apk-install haproxy  
EXPOSE 80  
EXPOSE 8080  
VOLUME /etc/haproxy  
CMD ["haproxy", "-d", "-f", "/etc/haproxy/haproxy.cfg"]

