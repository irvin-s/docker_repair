FROM node:latest  
  
RUN mkdir /blockchain  
RUN mkdir /blockchain/model  
ADD package.json /blockchain/  
ADD app.js /blockchain/  
ADD blockchainModule.js /blockchain/  
ADD model/BlockModel.js /blockchain/model/  
  
RUN cd /blockchain && npm install  
  
EXPOSE 3001  
EXPOSE 6001  
ENTRYPOINT cd /blockchain && npm install && PEERS=$PEERS npm start

