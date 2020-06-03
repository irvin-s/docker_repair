FROM node:5.1.1  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /unicorn && cp -a /tmp/node_modules /unicorn  
  
WORKDIR /unicorn  
ADD . /unicorn/  
  
EXPOSE 3000  
CMD npm start  

