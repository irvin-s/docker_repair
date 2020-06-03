FROM duraark/microservice-base  
  
RUN DEBIAN_FRONTEND=noninteractive  
RUN apt-get update  
  
# FIXXME: are 'tools' and 'schemas' needed anymore?  
RUN mkdir -p /opt/duraark-metadata /duraark/tools /duraark/schemas  
COPY ./ /opt/duraark-metadata  
  
WORKDIR /opt/duraark-metadata/src  
  
RUN npm install  
  
EXPOSE 5012  
CMD ["sails", "lift", "--prod"]  

