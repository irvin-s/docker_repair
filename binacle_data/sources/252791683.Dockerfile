FROM node:carbon  
WORKDIR /usr/src/fitplan-project  
COPY package.json ./  
COPY package-lock.json ./  
RUN npm install  
COPY . .  
EXPOSE 80  
CMD [ "npm", "start" ]  

