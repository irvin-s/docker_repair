FROM node:latest  
  
MAINTAINER Christofer Olaison  
  
ENV NODE_ENV=production  
  
ENV PORT=3000  
COPY ./package.json /var/www/package.json  
  
WORKDIR /var/www  
  
RUN npm install  
  
COPY . /var/www  
  
RUN npm run build:client  
  
EXPOSE $PORT  
  
ENTRYPOINT ["npm", "start"]  

