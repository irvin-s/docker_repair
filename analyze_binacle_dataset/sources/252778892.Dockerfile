FROM abiosoft/caddy  
MAINTAINER JD Courtoy <jd@courtoy.io>  
  
ENV CADDY_FILE /etc/Caddyfile  
COPY Caddyfile /etc/Caddyfile  
COPY entry.sh /  
RUN chmod +x /entry.sh  
  
ENTRYPOINT [ "/entry.sh" ]  
CMD [ "/usr/bin/caddy", "-conf /etc/Caddyfile", "-log stdout", "-agree" ]  

