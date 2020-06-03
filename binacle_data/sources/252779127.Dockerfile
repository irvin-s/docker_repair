FROM node:8-alpine  
RUN apk add --no-cache git \  
&& npm install -g npm@latest \  
&& rm -r ~/.npm  

