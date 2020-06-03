FROM node:8.1.4-wheezy  
WORKDIR /app  
COPY . .  
RUN npm install  
CMD ["npm", "run", "start"]

