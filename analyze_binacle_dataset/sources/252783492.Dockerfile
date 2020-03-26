FROM haproxy:alpine  
  
ENV CONNECTION_TIMEOUT 5m  
  
COPY custom-entrypoint.sh /  
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg.tpl  
  
ENTRYPOINT ["/custom-entrypoint.sh"]  
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]  

