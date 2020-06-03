FROM debian:wheezy  
RUN apt-get update && \  
apt-get install -y nginx && \  
rm -rf /var/lib/apt/lists/*  
VOLUME ["/var/cache/nginx"]  
EXPOSE 80 443  
RUN echo "<h1>Curso Docker</h1>" | \  
tee /usr/share/nginx/www/index.html  
CMD ["nginx", "-g", "daemon off;"]  
  

