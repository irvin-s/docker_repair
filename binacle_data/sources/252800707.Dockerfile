FROM node:4.7.0  
COPY src /  
RUN npm install  
CMD ["node", "main.js"]  

