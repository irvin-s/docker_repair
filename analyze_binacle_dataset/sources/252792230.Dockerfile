FROM node:alpine  
MAINTAINER whitecat.chayakorn@gmail.com  
WORKDIR . /src  
EXPOSE 8088  
ENV ME_CONFIG_EDITORTHEME="default" \  
ME_CONFIG_MONGODB_SERVER="mongo" \  
ME_CONFIG_MONGODB_ENABLE_ADMIN="true" \  
ME_CONFIG_BASICAUTH_USERNAME="" \  
ME_CONFIG_BASICAUTH_PASSWORD="" \  
VCAP_APP_HOST="0.0.0.0"  
ENV MONGO_EXPRESS 0.42.2  
CMD ["npm","start"]  
  
RUN npm install mongo-express  
  
WORKDIR /lpru-tr/public  
  
#database  
VOLUME CREATE --name trainning-nrDB \  
  
  
CMD ["node", "server.js" ]  

