FROM blachniet/goalpine:3.6  
ADD ./caddy /usr/local/bin/  
ADD ./Caddyfile /etc/caddy/Caddyfile  
ADD ./README.md /srv/index.md  
WORKDIR /srv  
  
# Set the directory that caddy uses to store certificates  
# and private keys.  
# https://caddyserver.com/docs/automatic-https#the-caddy-folder  
ENV CADDYPATH=/etc/caddy/crypto  
  
EXPOSE 80 443  
ENTRYPOINT ["/usr/local/bin/caddy"]  
CMD ["-conf", "/etc/caddy/Caddyfile", "-agree"]  

