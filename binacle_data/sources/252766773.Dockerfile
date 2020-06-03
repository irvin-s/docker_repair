FROM node:4.2.2  
EXPOSE 3000  
RUN mkdir /src  
WORKDIR /src  
  
ADD . /src  
  
RUN npm config set python python2.7  
  
RUN npm install --unsafe-perm  
  
CMD npm start  

