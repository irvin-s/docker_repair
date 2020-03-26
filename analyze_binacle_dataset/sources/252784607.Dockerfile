FROM node:9-alpine  
MAINTAINER BlackGlory <woshenmedoubuzhidao@blackglory.me>  
  
WORKDIR /app  
ADD . /app  
  
RUN yarn  
RUN yarn build  
  
EXPOSE 8080  
CMD yarn start  

