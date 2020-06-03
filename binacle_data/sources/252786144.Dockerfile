FROM node:6.3-slim  
  
ENV APP_DIR /opt/live-reload  
  
WORKDIR $APP_DIR  
  
COPY package.json $APP_DIR  
  
RUN npm install  
  
COPY . .  
  
ENTRYPOINT [ "node" ]  
CMD [ "server.js" ]  

