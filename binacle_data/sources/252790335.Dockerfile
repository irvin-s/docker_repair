FROM gliderlabs/alpine  
  
MAINTAINER Graham Taylor <graham.x.taylor@capgemini.com>  
  
RUN apk --update add nodejs  
  
# Install app dependencies  
COPY . /app  
RUN cd /app && npm install  
  
EXPOSE 8080  
CMD ["node", "/app/server.js"]  

