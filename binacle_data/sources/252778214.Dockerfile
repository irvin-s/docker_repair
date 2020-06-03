FROM node:6  
RUN apt-get update && apt-get install -y rsync  
RUN npm i -g gulp  
  
WORKDIR /data  
  
COPY package.json /data/package.json  
  
RUN npm install  
  
ENTRYPOINT ["gulp"]

