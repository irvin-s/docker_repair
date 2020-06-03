  
FROM node:7.3.0  
LABEL Name=node-app Version=1.0.0  
MAINTAINER Diebold Nixdorf  
COPY package.json /tmp/package.json  
RUN cd /tmp && npm install --production  
RUN mkdir -p /usr/src/app && mv /tmp/node_modules /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
EXPOSE 3000  
ENV NODE_ENV production  
ENV PRICE_SERVICE http://10.113.132.91:4002/wsgetPrecoOnline  
ENV STORE_CODE 149  
ENV USER_ID 0  
ENV PORT 3000  
ENV LOG_PRICE_REQUEST true  
CMD npm start  

