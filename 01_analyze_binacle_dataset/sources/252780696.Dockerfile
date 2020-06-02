FROM node:4-onbuild  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY ./app/package.json /usr/src/app/  
RUN npm install  
  
RUN npm install -g nodemon  
  
# Bundle app source  
COPY ./app /usr/src/app  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

