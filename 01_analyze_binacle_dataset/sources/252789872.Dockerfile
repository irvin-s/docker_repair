FROM node:argon  
WORKDIR /usr/src/app  
ADD package.json /usr/src/app  
RUN npm install  
ADD . /usr/src/app  
CMD /usr/src/app/cli.js  

