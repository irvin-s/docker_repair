FROM node:0.12.2  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN git clone https://github.com/coogleyao/docker-koa.git /usr/src/app  
RUN npm install  
  
EXPOSE 8080  
CMD ["npm", "start"]  

