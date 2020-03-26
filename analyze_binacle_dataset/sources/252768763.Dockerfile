FROM node:0.10  
ENV NODE_ENV=production  
  
WORKDIR /code  
  
ADD package.json /code/  
  
RUN npm install  
  
ADD . /code/  
  
ENTRYPOINT ["node", "/code/index.js"]  

