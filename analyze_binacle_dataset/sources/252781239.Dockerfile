FROM node:8.9.1-alpine  
  
RUN apk add --no-cache --virtual .persistent-deps \  
curl \  
openssl \  
make \  
gcc \  
g++ \  
python \  
py-pip \  
&& npm install --silent --save-dev -g \  
typescript  
  
VOLUME ["/app"]  
WORKDIR /app  

