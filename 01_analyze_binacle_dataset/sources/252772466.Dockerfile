FROM node:8-alpine  
  
EXPOSE 3000  
WORKDIR /opt/qi-dashboard-backend  
  
COPY . /opt/qi-dashboard-backend  
  
RUN apk add --no-cache --virtual build-dependencies git && \  
npm install --production && \  
chown -R node:node . && \  
npm cache clean --force && \  
apk del build-dependencies  
  
USER node  
  
CMD ["node","launch-qi-api.js"]  

