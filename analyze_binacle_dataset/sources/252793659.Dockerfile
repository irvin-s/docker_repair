FROM node:6.2.2  
COPY package.json /src/package.json  
  
WORKDIR /src  
  
RUN npm install  
  
COPY . /src  
  
RUN npm run build  
  
EXPOSE 8080  
CMD ["npm","start"]  

