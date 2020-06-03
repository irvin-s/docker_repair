FROM rocker/geospatial  
  
WORKDIR /app  
  
ADD . /app  
  
CMD ["./script.R"]  
  

