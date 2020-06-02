FROM danslinky/docker-elasticsearch:latest  
  
MAINTAINER dan@danslinky.co.uk  
  
# Override config, otherwise plug-in install will fail  
COPY config /elasticsearch/config  
  
# Set environment  
ENV NAMESPACE default  
ENV DISCOVERY_SERVICE elasticsearch-discovery  

