FROM debian:wheezy  
RUN apt-get update && \  
apt-get install -y nginx && \  
rm -rf /var/lib/apt/lists/*  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
RUN echo "<h1>Curso Docker V4</h1>" > /usr/share/nginx/www/index.html  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

