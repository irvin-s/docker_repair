FROM kyma/docker-nginx  
  
COPY p/ /var/www  
CMD 'nginx'

