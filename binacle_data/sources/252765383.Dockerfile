FROM mhart/alpine-node:4  
MAINTAINER "Michal J. Kubski" <michal.kubski@gmail.com>  
ENV container docker  
RUN npm install express request  
COPY /app.js /  
EXPOSE 8080  
USER nobody  
ENTRYPOINT node /app.js  
  

