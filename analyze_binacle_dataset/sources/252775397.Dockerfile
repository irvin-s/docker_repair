FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Install pm2 so we can run our application  
RUN npm i -g pm2  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 3000  
CMD ["pm2", "start", "processes.json", "--no-daemon"]  

