FROM kyma/docker-nginx  
ADD src/ /var/www  
CMD 'nginx'  

