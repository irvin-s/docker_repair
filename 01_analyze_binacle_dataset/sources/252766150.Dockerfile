FROM node:0.10  
RUN npm install --global handlebars-cmd  
ENTRYPOINT ["handlebars"]  

