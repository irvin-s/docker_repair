FROM traefik:latest  
ADD traefik.toml .  
ADD acme.json .  
RUN chmod 600 /acme.json  
EXPOSE 80  
EXPOSE 443  
EXPOSE 8080  

