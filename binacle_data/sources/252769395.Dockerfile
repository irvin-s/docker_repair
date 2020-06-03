FROM scratch  
COPY caddy Caddyfile home.html /  
EXPOSE 2015  
ENTRYPOINT ["/caddy"]  

