FROM anchore/anchore-engine:latest  
  
RUN mkdir -p /config  
  
COPY config.yaml /config/  

