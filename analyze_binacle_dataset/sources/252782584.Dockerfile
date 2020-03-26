FROM node:4  
  
RUN mkdir -p /sinopia/config && \  
mkdir -p /sinopia/service && \  
mkdir -p /sinopia/storage  
  
WORKDIR /sinopia/service  
RUN npm install --production sinopia  
ADD default-config.yaml /sinopia/config/config.yaml  
  
VOLUME /sinopia/config  
VOLUME /sinopia/storage  
  
CMD ["./node_modules/.bin/sinopia", "--config", "/sinopia/config/config.yaml"]  

