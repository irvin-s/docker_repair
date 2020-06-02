# Initialize Docker image.  
FROM r-base  
MAINTAINER asherkhb  
  
# Install ebutterfly-sdm dependencies.  
RUN install2.r \  
raster \  
sp \  
dismo \  
maptools  
  
# Copy code to Docker image.  
COPY src/ /usr/local/src  
WORKDIR /usr/local  
  
# Set up entry.  
ENTRYPOINT ["./src/run_model.sh"]  
CMD ["help"]  
  

