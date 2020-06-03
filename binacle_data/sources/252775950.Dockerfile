FROM alpine:3.2  
RUN apk add --update openssh-client git tar  
  
ADD caddy /usr/bin/  
  
RUN chmod 0755 /usr/bin/caddy  
  
EXPOSE 8080 8443  
WORKDIR /srv  
  
ADD Caddyfile /etc/caddy/Caddyfile  
ADD public/ /srv/public/  
ADD publics/ /srv/publics/  
ADD certs/ /srv/certs  
  
ENTRYPOINT ["/usr/bin/caddy"]  
CMD ["--conf", "/etc/caddy/Caddyfile"]  

