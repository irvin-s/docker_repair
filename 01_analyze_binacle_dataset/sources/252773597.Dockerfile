FROM node  
  
WORKDIR /app  
  
COPY package.json ./  
RUN npm cache clean  
RUN npm install  
  
COPY . ./  
COPY ./src/server/local.config.example.js ./src/server/local.config.js  
RUN npm run build  
  
EXPOSE 9999  
ENV NODE_ENV=production PORT=9999 CONFIG=server  
  
ENTRYPOINT node compiled/server/boot.js  

