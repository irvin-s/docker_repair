FROM node:6-alpine  
  
ENV NODE_ENV=production  
  
RUN mkdir -p /app  
WORKDIR /app  
COPY package.json .  
RUN npm install --production  
COPY src src/  
COPY config/default.yaml config/custom-environment-variables.yaml config/  
  
EXPOSE 80  
CMD [ "npm", "start" ]  

