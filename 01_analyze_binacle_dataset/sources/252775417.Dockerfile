FROM kyma/docker-nginx  
  
COPY ./ /var/www  
  
EXPOSE 80  
CMD 'nginx'  

