FROM node:9.4-alpine  
  
WORKDIR /app  
  
COPY package.json /app  
RUN apk --update add git && yarn && yarn cache clean  
  
COPY . /app  
  
CMD ["node", "."]  

