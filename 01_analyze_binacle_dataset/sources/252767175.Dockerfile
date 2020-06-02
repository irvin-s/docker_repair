FROM jumanjiman/caddy  
  
USER root  
RUN apk add --update bash && rm -rf /var/cache/apk/*  
COPY bootstrap.sh /home/caddy/bootstrap.sh  
  
EXPOSE 80 443  
WORKDIR /home/caddy  
ENTRYPOINT ["/home/caddy/bootstrap.sh"]

