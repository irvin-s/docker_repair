FROM node:8-onbuild  
RUN npm run webpack  
  
CMD ["node", "server.js"]  

