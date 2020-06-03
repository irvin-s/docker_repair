FROM akohlbecker/base:latest  
  
RUN apt-get update && \  
apt-get install -y nginx curl && \  
apt-get -y autoremove && \  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /tmp/*  
  
ADD conf.d /etc/nginx/conf.d  
ADD snippets /etc/nginx/snippets  
ADD sites-enabled /etc/nginx/sites-enabled  
ADD cloudflare-origin-pull.pem /etc/ssl/certs  
  
ADD app /app  
WORKDIR /app  
  
EXPOSE 80 443  
CMD ["/app/boot", "nginx"]  

