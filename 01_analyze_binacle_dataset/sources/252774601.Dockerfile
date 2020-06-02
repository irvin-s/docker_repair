FROM barryrowlingson/geospatialplus  
  
WORKDIR /app  
  
ADD . /app  
  
CMD ["./run.sh"]  
  

