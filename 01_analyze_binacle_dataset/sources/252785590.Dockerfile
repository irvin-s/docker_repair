FROM node:4-onbuild  
RUN npm install npm -g  
  
RUN npm set progress=false && \  
npm install -g --progress=false yarn  

