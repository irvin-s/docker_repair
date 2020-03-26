FROM alpine  
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz>  
  
ADD ./install-caddy.sh /install-caddy.sh  
RUN /install-caddy.sh && rm /install-caddy.sh  
  
# extract executable to root  
ADD Caddyfile /etc/caddy/Caddyfile  
  
VOLUME /etc/caddy  
VOLUME /var/www  
VOLUME /var/run/caddy  
  
EXPOSE 80  
EXPOSE 443  
ENTRYPOINT ["/caddy", "-agree=true", "-conf=/etc/caddy/Caddyfile"]  

