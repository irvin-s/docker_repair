FROM colstrom/alpine  
RUN apk-install haproxy  
EXPOSE 5000  
VOLUME ["/etc/haproxy"]  
ENTRYPOINT ["/usr/sbin/haproxy", "-db", "-f", "/etc/haproxy/haproxy.cfg"]  

