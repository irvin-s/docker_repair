FROM node:8.1.1-alpine  
RUN apk add --no-cache zip bash curl &&\  
npm install yargs archiver aws-sdk --save &&\  
npm cache clean --force  
COPY multipart.js /as-files/  
RUN chmod 755 /as-files/*  

