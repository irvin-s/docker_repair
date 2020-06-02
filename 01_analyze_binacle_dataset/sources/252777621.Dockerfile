FROM node:9  
ADD app /app  
WORKDIR /app  
RUN npm i  
VOLUME '/app/logs'  
CMD ./index.js  

