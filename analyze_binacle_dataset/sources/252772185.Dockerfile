FROM node:5.6  
RUN mkdir /app  
ADD package.json /app/package.json  
  
RUN cd /app && npm install  
WORKDIR /app  
ADD . /app  
  
CMD ["npm", "start"]  

