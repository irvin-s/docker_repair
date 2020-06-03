FROM node:latest  
EXPOSE 3000  
ADD app.js app.js  
CMD ["node", "app.js"]  

