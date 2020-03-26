FROM maven:3.5.0-jdk-8-alpine  
RUN apk add --no-cache libxml2-utils nodejs &&\  
npm install npm@latest -g &&\  
npm install yargs archiver aws-sdk --save &&\  
npm cache clean --force  
RUN mkdir -p /as-files  
COPY multipart.js copy-to-s3 show-versions /as-files/  
RUN chmod 755 /as-files/*  

