FROM haproxy:1.5  
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg  
  
EXPOSE 10000  

