FROM alpine:3.2  
RUN apk add --update openssh-client git tar  
  
ADD caddy /usr/bin/  
  
RUN chmod 0755 /usr/bin/caddy \  
&& /usr/bin/caddy -version  
  
EXPOSE 8080 8443  
WORKDIR /srv  
  
ADD Caddyfile /etc/Caddyfile  
ADD public2/ /srv/public/  
ADD publics2/ /srv/publics/  
ADD certs/ /srv/certs  
  
ENTRYPOINT ["/usr/bin/caddy"]  
CMD ["--conf", "/etc/Caddyfile"]  

