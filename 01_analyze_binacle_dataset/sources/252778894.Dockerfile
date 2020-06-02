FROM node:5.1  
RUN npm install -g nodemon  
  
RUN mkdir /src  
WORKDIR /src  
  
#ADD nodemon.json nodemon.json  
#ADD package.json package.json  
#RUN npm install  
CMD [ "nodemon -L", "app.js" ]  

