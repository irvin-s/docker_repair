FROM node:0-slim  
  
ADD . /tmp  
RUN sh /tmp/docker-provision.sh  
WORKDIR /docs  
  
# run apib2swagger when the container starts  
ENTRYPOINT ["apib2swagger"]  

