FROM node:5.11.0  
# Create app directory  
RUN mkdir -p /usr/src/six-degrees  
WORKDIR /usr/src/six-degrees  
  
RUN export NODE_PATH=/usr/local/lib/node_modules/  
  
# Install app dependencies  
RUN npm install -g gulp  
RUN npm install -g jspm  
COPY package.json /usr/src/six-degrees  
  
# Bundle app source  
COPY . /usr/src/six-degrees  
  
RUN npm install --unsafe-perm=true  
  
EXPOSE 8080  
CMD ["npm", "run", "release"]  

