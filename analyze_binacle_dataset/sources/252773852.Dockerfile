FROM node:6.3.1  
LABEL version="1.0"  
LABEL description="WebScraping Account Service"  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
VOLUME ["/var/log/"]  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

