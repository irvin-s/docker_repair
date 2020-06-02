FROM node:0.12.7-slim  
  
COPY package.json /package.json  
  
RUN npm install  
  
COPY . /  
  
ENTRYPOINT [ "node" ]  
CMD [ "app.js"]  

