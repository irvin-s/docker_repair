FROM jonnybgod/alpine-nginx:master  
  
WORKDIR /src  
  
ADD . .  
RUN cp nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443  
ENTRYPOINT ["nginx"]

