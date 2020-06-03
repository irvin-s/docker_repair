FROM node:6  
RUN npm install --global envhandlebars  
ENTRYPOINT envhandlebars  

