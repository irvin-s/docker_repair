FROM node:alpine  
LABEL maintainer="Devrecipe, Ltd <hello@devrecipe.com>"  
  
COPY server.js .  
COPY package.json .  
  
RUN mkdir objects  
RUN npm install  
  
ENV PORT=80  
EXPOSE 80  
ENTRYPOINT ["npm", "start"]

