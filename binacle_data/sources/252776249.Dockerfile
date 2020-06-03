FROM hashicorp/terraform:0.11.0  
COPY docker-entrypoint.sh /usr/local/bin/  
  
WORKDIR /workdir  
ENTRYPOINT ["docker-entrypoint.sh"]  

