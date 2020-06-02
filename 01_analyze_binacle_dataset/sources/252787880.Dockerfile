FROM node:alpine  
  
ENV APP /app  
RUN mkdir $APP  
WORKDIR $APP  
COPY package.json yarn.lock ./  
RUN yarn install --production  
ADD . $APP  
EXPOSE 8080  
CMD ["node", "server.js"]  

