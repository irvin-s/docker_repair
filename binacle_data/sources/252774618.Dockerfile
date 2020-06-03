FROM node:alpine  
  
EXPOSE 80  
COPY src /usr/src/app  
  
WORKDIR /usr/src/app  
  
RUN npm install -g nodemon  
RUN npm install  
  
ENV SERVER_VERSION=0.1.0  
# CMD sh  
CMD ["nodemon", "app.js"]  

