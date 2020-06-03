FROM conjurinc/s3-url-signer  
  
ENV BUCKET_NAME conjur-dev-lxc-images  
ENV DEFAULT_VERSION 2015-08-07_133915  
  
WORKDIR /  
  
ADD start.sh /start.sh  
ADD app.rb /app.rb  
ADD get.secrets /get.secrets  
  
ENTRYPOINT [ "/start.sh" ]  

