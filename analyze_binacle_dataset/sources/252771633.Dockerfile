FROM node:7.4  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
COPY . /usr/src/app  
  
RUN mkdir -p /usr/src/app/log  
ENV LOG_PATH /usr/src/app/log  
  
EXPOSE 8080  
CMD ["npm", "start"]  

