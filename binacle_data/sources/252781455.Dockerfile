FROM node:latest  
  
MAINTAINER Boris Gorbylev <ekho@ekho.name>  
  
WORKDIR /sinopia  
  
ADD config.yaml /sinopia/config.yaml  
  
RUN npm install -g sinopia \  
&& npm cache clean \  
&& mkdir -p /sinopia/storage/cache \  
&& chmod -R g+rw /sinopia \  
&& chgrp -R daemon /sinopia  
  
USER daemon  
  
EXPOSE 4873  
VOLUME /sinopia/storage  
  
CMD ["sinopia"]  

