FROM rocker/geospatial:latest  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
libmagick++-dev  
  
RUN install2.r --error \  
magick \  
gdalUtils \  
geosphere \  
leaflet \  
devtools  
  
  

