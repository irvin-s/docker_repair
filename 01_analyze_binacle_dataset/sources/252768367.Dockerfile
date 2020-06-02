FROM node:8  
LABEL name "Dynasystem Exercises"  
  
COPY . .  
RUN npm install  
  
EXPOSE 80  
CMD ["npm", "start"]  

