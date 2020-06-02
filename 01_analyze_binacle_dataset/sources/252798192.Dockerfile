FROM php:7.0.4-fpm  
  
RUN apt-get update && \  
apt-get install -y nginx &&\  
rm -rf /var/lib/apt/lists/*  
  
ADD . /usr/local/  
  
RUN chmod a+x /usr/local/entrypoint.sh  
  
CMD ["/usr/local/entrypoint.sh"]

