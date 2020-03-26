FROM scratch  
MAINTAINER Adam Duke <adam.v.duke@gmail.com>  
  
ENV SITE_ROOT /srv/caddy  
ENV CONFIG_DIR $SITE_ROOT/config/  
ENV PUBLIC_DIR $SITE_ROOT/public/  
  
COPY bin/caddy /caddy  
COPY config/Caddyfile $CONFIG_DIR/Caddyfile  
COPY public/index.html $PUBLIC_DIR/index.html  
  
WORKDIR $CONFIG_DIR  
  
CMD ["/caddy"]  
  
EXPOSE 80  
EXPOSE 443  

