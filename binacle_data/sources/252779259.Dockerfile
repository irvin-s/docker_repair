FROM node:latest  
MAINTAINER c036  
  
WORKDIR /app  
COPY . /app  
  
RUN npm install -g yarn && yarn build  
  
EXPOSE 8080  
CMD ["node", "./dist/server.js"]

