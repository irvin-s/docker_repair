FROM haproxy:1.8-alpine  
  
COPY dev.pem /usr/local/etc/haproxy/dev.pem  
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg  

