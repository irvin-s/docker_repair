FROM node:latest  
  
EXPOSE 8081  
COPY package.json /src/package.json  
#COPY npm-shrinkwrap.json /src/npm-shrinkwrap.json  
RUN cd /src; npm install  
  
COPY . /src  
  
WORKDIR /src  
  
RUN ./node_modules/.bin/gulp build  
  
CMD ["npm", "start"]  

