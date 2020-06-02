FROM arangodb/arangodb:3.0.7  
MAINTAINER Andy Barilla  
  
ENV ARANGO_RANDOM_ROOT_PASSWORD=1  
COPY foxx /tmp/bandheap-foxx  
  
ADD bandheap-setup.sh /docker-entrypoint-initdb.d/  
ADD cities.json /tmp  
  

