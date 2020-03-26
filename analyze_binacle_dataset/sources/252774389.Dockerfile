FROM node:8.9.4  
RUN mkdir -p /usr/smartjoules/api  
WORKDIR /usr/smartjoules/api  
COPY ./ /usr/smartjoules/api  
RUN npm install -g pm2 && npm install  
EXPOSE 1337  
CMD pm2-docker process.json --env production  

