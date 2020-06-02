FROM node:alpine  
  
RUN apk add --update make gcc g++ python curl git krb5-dev zeromq-dev  
COPY . .  
RUN npm install zeromq --zmq-external --save  
RUN npm install --production  
  
LABEL databox.type="driver"  
  
EXPOSE 8080  
CMD ["npm","start"]  
#CMD ["sleep","2147483647"]  

