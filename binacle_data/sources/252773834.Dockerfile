FROM node:alpine  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app  
RUN npm install  
  
COPY . /usr/src/app  
  
ENV KAFKA_REST_PROXY_IP "localhost"  
ENV KAFKA_REST_PROXY_PORT 8082  
ENV REDIS_IP "localhost"  
ENV REDIS_PORT 6379  
RUN npm run build  
  
EXPOSE 4000  
CMD ["npm", "start"]  

