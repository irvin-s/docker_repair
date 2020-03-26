FROM node:8  
WORKDIR /app  
COPY . /app  
RUN npm install  
CMD node bot.js  
EXPOSE 3000  

