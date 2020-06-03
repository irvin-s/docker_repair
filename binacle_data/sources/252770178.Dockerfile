FROM node:9  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Copy package.json file  
COPY package.json /usr/src/app/  
  
# Install app dependencies  
RUN yarn install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Expose 8080 port  
EXPOSE 8080  
# Run app  
CMD [ "yarn", "run", "start" ]  

