FROM node:0.10.32  
EXPOSE 3000  
ADD . /app  
WORKDIR /app  
RUN npm install  
  
ENTRYPOINT ["node", "app.js"]

