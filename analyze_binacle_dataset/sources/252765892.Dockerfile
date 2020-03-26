FROM node  
  
MAINTAINER "Tobias Mose" <mosetobias@outlook.de>  
  
RUN npm install -g nodemon  
RUN npm install -g babel-cli  
RUN npm install  
  
ENV RUN_PATH /data/root  
  
WORKDIR $RUN_PATH  
ENTRYPOINT npm start  

