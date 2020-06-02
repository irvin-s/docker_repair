FROM nginx:1.12.0-alpine  
  
RUN apk update && \  
apk add certbot letsencrypt-nosudo m4 && \  
rm -rf /var/cache/apk/*  
  
COPY domain.conf.m4 /etc/nginx/domain.conf.m4  
  
WORKDIR /  
COPY entrypoint.sh .  
RUN chmod +rx entrypoint.sh  
  
ENTRYPOINT ["/bin/sh", "/entrypoint.sh" ]  
  

