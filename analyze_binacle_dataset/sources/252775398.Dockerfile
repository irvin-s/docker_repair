FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
RUN npm install body-parser  
# Install forever so we can run our application  
RUN npm i -g forever  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 5000  
CMD ["forever", "app.js"]  

