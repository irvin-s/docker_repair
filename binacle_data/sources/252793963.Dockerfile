FROM gliderlabs/alpine  
MAINTAINER Ken Herner <ken@modulus.io>  
  
ADD bootstrap.sh /tmp/bootstrap.sh  
RUN chmod +x /tmp/bootstrap.sh && sh /tmp/bootstrap.sh  
  
EXPOSE 8200 8500  
ENTRYPOINT ["/usr/local/bin/vault"]  

