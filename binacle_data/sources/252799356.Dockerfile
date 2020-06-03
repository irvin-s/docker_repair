FROM node:8-alpine  
LABEL maintainer "Michael Granados <contato@dgmike.com.br>"  
  
RUN npm install -g hercule  
  
RUN mkdir -p /doc  
  
WORKDIR /doc  
  
ENTRYPOINT ["hercule"]  

