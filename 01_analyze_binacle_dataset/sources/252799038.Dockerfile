FROM node:alpine  
LABEL maintainer="Devrecipe, Ltd <hello@devrecipe.com>"  
  
WORKDIR /usr/src/app  
COPY package.json .  
COPY config.json .  
COPY index.js .  
COPY public public  
  
RUN npm install  
  
ENV PORT 80  
EXPOSE 80  
ENTRYPOINT ["npm", "start"]

