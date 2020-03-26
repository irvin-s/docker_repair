FROM node:10.3.0  
RUN npm config set color false && npm config set loglevel warn  
RUN npm install -g npm@6.1.0  
RUN npm install -g s3-cli@0.13.0  

