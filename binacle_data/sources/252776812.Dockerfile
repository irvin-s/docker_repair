FROM node:6  
WORKDIR /app  
ADD . .  
RUN npm install  
EXPOSE 3000  
CMD ["npm", "start"]  

