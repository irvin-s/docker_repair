FROM alpine  
  
# ENV NODE_SRC /usr/local/src/node  
# install node and npm  
RUN apk update  
RUN apk add bash nodejs g++ python make  
  
# create a node directory  
RUN mkdir -p /usr/local/src/node/  
WORKDIR /usr/local/src/node/  
  
# install base packages for node  
RUN npm install express kafka-node body-parser  
  
# add our .js files to directory  
ADD ./src /usr/local/src/node/  
  
# exposing different port  
EXPOSE 8125  
# run our app  
CMD [ "node", "kafka-node.js" ]  
  

