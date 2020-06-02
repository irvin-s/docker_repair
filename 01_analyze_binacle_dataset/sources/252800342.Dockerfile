FROM node:8  
WORKDIR /opt/subscription-manager  
EXPOSE 80  
CMD ["npm", "run", "subscription"]  
  
COPY package.json .  
COPY package-lock.json .  
RUN npm install  
  
COPY . .  
RUN npm run-script build  
  

