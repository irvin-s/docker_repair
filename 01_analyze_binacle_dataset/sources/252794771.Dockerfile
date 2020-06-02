FROM node:alpine  
  
RUN npm install -g pg-kinesis-bridge  
  
CMD pg-kinesis-bridge -c ${CHANNEL} -s ${STREAMNAME}  

