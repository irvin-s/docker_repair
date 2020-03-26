  
FROM node:8-slim  
RUN apt-get update && apt-get install -y build-essential python  
WORKDIR /build  
COPY package.json /build  
RUN npm install --production  
COPY . /build  
#VOLUME /build  
USER node  
CMD ["node","src/worker/index.js"]

