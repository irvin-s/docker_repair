FROM node:alpine  
  
RUN apk add --update make gcc g++ python curl git krb5-dev zeromq-dev && \  
npm install zeromq --zmq-external --save && \  
apk del make gcc g++ python curl git krb5-dev  
  
ADD ./package.json /package.json  
RUN npm install --production && npm run clean  
  
ADD ./src /src  
RUN mkdir /slaStore && mkdir /certs  
  
VOLUME ["/slaStore","/certs"]  
  
LABEL databox.type="container-manager"  
  
EXPOSE 8989  
CMD ["npm", "start"]  
#CMD ["sleep","99999"]  

