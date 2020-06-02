FROM node:8.6.0  
MAINTAINER Ferran Vila ferran.vila.conesa@gmail.com  
  
WORKDIR /home/app  
EXPOSE 9000  
COPY . /home/app  
RUN npm install --loglevel warn  
RUN npm run build:prod  
  
CMD ["node", "server/app.js"]  

