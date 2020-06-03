FROM gliderlabs/registrator:latest  
  
MAINTAINER Cloud Under <hi@cloudunder.io>  
  
COPY registrator-aws.sh /bin/  
  
ENTRYPOINT ["/bin/registrator-aws.sh"]  

