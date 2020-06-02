FROM node:0.12  
RUN npm install --global https://github.com/erming/shout  
  
ENTRYPOINT shout  

