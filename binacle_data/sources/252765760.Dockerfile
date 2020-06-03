FROM node:4.2.6  
RUN npm install gulp -g  
  
COPY . /src/  
RUN cd /src; npm install  
  
EXPOSE 8080  
WORKDIR /src  
CMD ["node", "/src/dist/main.js"]  

