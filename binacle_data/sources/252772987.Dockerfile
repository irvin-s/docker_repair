FROM node:8.5  
MAINTAINER William <guardianangelhori75@gmail.com>  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app/  
COPY . /usr/src/app  
RUN npm install http-server -g  
RUN npm install  
RUN npm run build  
  
ENV NODE_ENV=production  
ENV PORT=8080  
EXPOSE 8080  
CMD ["http-server",".","-p","8080"]  

