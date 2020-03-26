FROM node:4-onbuild  
RUN npm run build  
  
ENV PRODUCTION=1  
EXPOSE 8080  

