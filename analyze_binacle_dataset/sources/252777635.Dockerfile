FROM hyperledger/composer-rest-server:0.17.6  
  
USER root  
  
RUN apk add \--no-cache bash  
  
# Add global composer modules to the path.  
ENV PATH /home/composer/.npm-global/bin:$PATH  
# Run in the composer users home directory.  
WORKDIR /root  

