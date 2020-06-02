FROM rocker/geospatial:3.4.3  
RUN install2.r --error \  
CARBayesST \  
splancs  
  
WORKDIR /app  
  
ADD . /app  
  
CMD ["/bin/bash"]  
  

