FROM postgres:9.6  
COPY arcts-ssl-entrypoint.sh /usr/local/bin/  
  
RUN chmod +x /usr/local/bin/arcts-ssl-entrypoint.sh && \  
chmod +x /usr/local/bin/docker-entrypoint.sh && \  
chmod +x /docker-entrypoint.sh && \  
ln -s /usr/local/bin/arcts-ssl-entrypoint.sh /  
  
ENTRYPOINT ["/arcts-ssl-entrypoint.sh"]  

