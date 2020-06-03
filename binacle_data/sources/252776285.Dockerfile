FROM node:6  
# Create app directory  
RUN mkdir -p /usr/src/dialupsite/  
WORKDIR /usr/src/dialupsite  
  
# Install app dependencies  
COPY package.json /usr/src/dialupsite/  
RUN npm install webpack@1.13.3 -g  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/dialupsite  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  
  

