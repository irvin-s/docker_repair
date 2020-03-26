FROM node:alpine  
  
ADD ./index.js /index.js  
  
CMD [ "node", "/index.js" ]  

