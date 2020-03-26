FROM node:7.9.0  
ENV NODE_PATH /install/node_modules/  
ENV PATH /install/node_modules/.bin:$PATH  
  
COPY package.json /install/package.json  
WORKDIR /install/  
RUN npm install  
  
VOLUME /app  
WORKDIR /app  

