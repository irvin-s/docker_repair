FROM gliderlabs/registrator:v7  
  
MAINTAINER wesecur.com "albert.verges@wesecur.com"  
COPY registrator-wrapper /bin/  
RUN chmod +x /bin/registrator-wrapper  
  
ENTRYPOINT ["/bin/registrator-wrapper"]

