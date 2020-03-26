FROM node:carbon-slim  
  
# Create app directory  
RUN mkdir /books-ms  
WORKDIR /books-ms  
  
# Install app dependencies  
COPY package.json /books-ms/  
RUN npm install  
  
# Bundle app source  
COPY . /books-ms/  
RUN npm run prepublish  
EXPOSE 3002  
CMD [ "npm", "run", "runServer" ]

