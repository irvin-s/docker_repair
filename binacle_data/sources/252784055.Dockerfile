FROM cpswan/node-red  
  
WORKDIR /root/.node-red  
  
RUN npm install node-red-node-mongodb  
  
# add our custom mongodb settings file  
ADD settings.js settings.js  
  
# add a default flows file. it will be copied into the data volume on init.  
ADD flows/biogrid-cortex-flows.json flows/biogrid-cortex-flows.json  
  
# turn the flows directory into a data volume  
VOLUME /root/.node-red/flows  

