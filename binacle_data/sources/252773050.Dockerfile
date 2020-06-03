FROM node:6  
RUN npm install -g nodemon  
RUN mkdir -p /usr/local/nodejs  
ADD nodejs-init.sh /usr/local/nodejs/nodejs-init.sh  
RUN chmod 755 /usr/local/nodejs/nodejs-init.sh

