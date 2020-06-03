FROM abiosoft/caddy  
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>  
  
ENV CADDY_FILE /etc/Caddyfile  
  
COPY ./entry.sh /  
RUN chmod +x /entry.sh  
  
ENTRYPOINT [ "/entry.sh" ]  
CMD [ "/usr/bin/caddy", "-conf /etc/Caddyfile", "-log stdout", "-agree" ]  

