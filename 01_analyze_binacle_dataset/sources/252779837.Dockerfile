FROM conjurinc/s3-url-signer  
  
ENV BUCKET_NAME conjur-dev-vmware-images  
ENV DEFAULT_VERSION 4.4  
WORKDIR /  
  
ADD start.sh /start.sh  
ADD app.rb /app.rb  
ADD get.secrets /get.secrets  
  
ENTRYPOINT [ "/start.sh" ]  

