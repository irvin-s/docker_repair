FROM afrith/node-xenial  
  
RUN apt-get update && apt-get install -y gdal-bin libmapnik-dev  

