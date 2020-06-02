FROM node:6  
MAINTAINER Andi N. Dirgantara <andi.nugroho@salestock.id>  
  
# install PM2 and update NPM  
RUN npm install -g pm2  
  
# create app directory  
RUN mkdir -p /app  
WORKDIR /app  
  
# copy project and run installation  
COPY . /app  
RUN rm -rf /app/node_modules  
RUN npm install  
RUN npm run build  
  
CMD [ "pm2", "start", "--no-daemon", "app.js"]  
EXPOSE 80  

