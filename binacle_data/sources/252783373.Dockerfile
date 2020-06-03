FROM traefik:raclette-alpine  
  
COPY entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
COPY traefik.tmpl /etc/traefik/traefik.tmpl  
  
EXPOSE 80  
ENTRYPOINT ["/entrypoint.sh"]  

