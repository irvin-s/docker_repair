FROM node:6.1  
RUN ["mkdir", "-p", "/app/public"]  
  
COPY examples/nginx/ /app/nginx/  
VOLUME /app/nginx  
  
COPY package.json /app/  
WORKDIR /app  
RUN npm install  
  
COPY plugins/ /app/plugins/  
COPY index.js /app/  
  
EXPOSE 80  
EXPOSE 443  
CMD npm start -- --no-daemon  

