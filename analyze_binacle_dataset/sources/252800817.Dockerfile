FROM readytalk/nodejs  
WORKDIR /app  
WORKDIR /app/views  
WORKDIR /app/public  
ADD server.js /app/  
ADD package.json /app/  
ADD index.html /app/views  
ADD css.css /app/public  
RUN npm install  

