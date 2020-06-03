FROM haproxy:1.5  
COPY haproxy.conf /usr/local/etc/haproxy/haproxy.cfg  
COPY start.sh /  
CMD /start.sh  

