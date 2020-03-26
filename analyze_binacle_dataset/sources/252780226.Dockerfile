FROM node:5.7.1-onbuild  
EXPOSE 3000  
RUN npm run build  

