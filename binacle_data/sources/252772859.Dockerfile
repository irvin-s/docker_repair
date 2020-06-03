FROM kyma/docker-nginx  
RUN mkdir -p /var/www  
ADD serve /serve  
  
CMD "/serve"  

