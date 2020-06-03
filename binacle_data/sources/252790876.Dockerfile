FROM node:6.2  
  
ADD . .  
  
RUN npm install  
RUN npm run build  
  
ENV PORT 80  
EXPOSE 80  
  
CMD ["npm", "start"]  

