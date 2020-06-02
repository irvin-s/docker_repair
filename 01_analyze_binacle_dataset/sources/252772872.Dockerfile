FROM node:9.1.0  
WORKDIR /APP  
RUN npm install --global nodemon  
RUN npm install iota.lib.js ejs express socket.io --save  
COPY . /APP  
EXPOSE 80  
CMD ["nodemon", "-L", "/APP"]

