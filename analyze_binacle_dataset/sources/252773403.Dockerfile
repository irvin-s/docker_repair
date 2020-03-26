FROM node:slim  
  
WORKDIR /app/  
  
COPY . /app/  
  
ENV NODE_ENV production  
  
RUN npm install --production  
RUN npm run build  
  
ENTRYPOINT ["npm", "run", "app"]  

