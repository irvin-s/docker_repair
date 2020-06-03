FROM node:latest  
# TODO: change to specific version later  
# Install app dependencies  
COPY package.json /src/package.json  
RUN cd /src; npm install --production  
  
# Bundle app source  
COPY . /src  
  
EXPOSE 3000  
CMD ["node", "/src/app.js"]

