FROM node:alpine  
RUN apk add \--no-cache \  
autoconf \  
automake \  
g++ \  
gcc \  
make \  
nasm \  
python \  
zlib-dev \  
&& npm install -g bower gulp grunt  
RUN apk add \--no-cache git  
WORKDIR /app  
USER node  

