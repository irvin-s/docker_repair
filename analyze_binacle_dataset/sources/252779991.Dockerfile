FROM containerize/caddy:base  
  
ENV PROXY_HOST=proxy  
ENV PROXY_PORT=80  
COPY Caddyfile /etc/Caddyfile  
  

