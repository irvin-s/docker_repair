FROM node:alpine  
EXPOSE 8080  
ENV NODE_ENV production  
RUN mkdir /app  
WORKDIR /app  
COPY package.json ./package.json  
RUN npm install --production  
COPY . .  
CMD ["npm", "start"]  

