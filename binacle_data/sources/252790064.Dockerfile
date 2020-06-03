FROM debian:jessie  
  
MAINTAINER Mickaël Canévet "mickael.canevet@camptocamp.com"  
RUN apt-get update && \  
apt-get install -y ca-certificates nginx-extras liburi-encode-perl && \  
rm -rf /var/lib/apt/lists/*  
  
# forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
VOLUME ["/var/cache/nginx"]  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

