FROM node:5.0  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
# Install app dependencies  
COPY package.json /usr/src/app  
#RUN npm install  
RUN npm install  
RUN npm install tsd -g  
RUN npm install -g typescript  
COPY . /usr/src/app  
EXPOSE 8081  
CMD [ "npm", "start" ]  
  

