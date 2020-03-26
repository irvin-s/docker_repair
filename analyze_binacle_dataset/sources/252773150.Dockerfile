FROM bfritscher/nodejs-grunt-bower  
RUN mkdir -p /app  
COPY package.json /app/package.json  
COPY Gruntfile.js /app/Gruntfile.js  
COPY tslint.json /app/tslint.json  
  
WORKDIR /app  
RUN npm install  
COPY /app /app/app  
COPY /typings /app/typings  
WORKDIR /app/app/public  
RUN bower install --allow-root  
WORKDIR /app  
RUN grunt  
  
# Define default command.  
CMD ["supervisor", "--watch", "/app/dist", "dist/server.js"]  

