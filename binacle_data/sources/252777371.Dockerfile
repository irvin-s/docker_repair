FROM zzrot/alpine-caddy  
COPY Caddyfile /etc/Caddyfile  
COPY . /var/www/html  
  

