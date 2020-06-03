FROM node:boron  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json yarn.lock /usr/src/app/  
RUN yarn install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Build and optimize react app  
RUN npm run build  
  
EXPOSE 8080  
CMD [ "npm", "run", "server" ]  

