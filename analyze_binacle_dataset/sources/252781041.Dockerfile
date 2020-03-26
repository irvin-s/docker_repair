FROM alpine  
  
LABEL maintainer="costadvl@gmail.com"  
  
# Enable EPEL for Node.js  
RUN apk add --update nodejs nodejs-npm  
  
# Copy app to /src  
COPY . /src  
  
WORKDIR /src  
  
# Install app and dependencies  
RUN npm install  
  
EXPOSE 8080  
ENTRYPOINT ["node", "./app.js"]  

