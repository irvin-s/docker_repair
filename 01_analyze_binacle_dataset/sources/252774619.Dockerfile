FROM node  
  
RUN npm install -g nodemon  
RUN npm install express  
RUN npm install ejs  
RUN npm install request  
  
VOLUME /usr/src/app  
  
WORKDIR /usr/src/app  
  
COPY app /usr/src/app  
  
CMD ["nodemon", "app.js"]  

