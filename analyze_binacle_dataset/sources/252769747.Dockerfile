FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
ADD package.json /usr/src/app/  
RUN npm config set registry http://registry.npmjs.org/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
WORKDIR /usr/src/app  
  
VOLUME ["/modules/vicibot"]  
ENV ["WEB_HOST", "http://web:8000"]  
CMD ["node", "main.js", "debug", "slack"]

