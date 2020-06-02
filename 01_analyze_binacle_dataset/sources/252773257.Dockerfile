FROM bhurlow/node  
ENV DEBUG='slack-docker-notify*'  
ADD . /app  
WORKDIR /app  
RUN npm install  
CMD node app.js  

