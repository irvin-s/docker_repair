FROM node:8.5  
WORKDIR /usr/src/app  
  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app  
  
# Setup workdir  
COPY . .  
  
# run  
EXPOSE 3000  
CMD ["make", "run"]  

