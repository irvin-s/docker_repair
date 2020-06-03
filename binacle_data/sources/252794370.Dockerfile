FROM node:alpine  
  
RUN apk add --update make gcc g++ python curl git krb5-dev zeromq-dev && \  
npm install zeromq --zmq-external --save && \  
apk del make gcc g++ python curl git krb5-dev  
  
ADD ./package.json /package.json  
RUN npm install --production  
  
ADD . .  
  
LABEL databox.type="app"  
  
EXPOSE 8080  
CMD ["npm","start"]  
#CMD ["sleep","2147483647"]  

