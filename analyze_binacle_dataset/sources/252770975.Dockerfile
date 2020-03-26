FROM node:latest  
  
LABEL maintainer "Alexander Groß <agross@therightstuff.de>"  
  
EXPOSE 8080  
WORKDIR /app  
COPY app .  
RUN npm install  
  
CMD ["node", "./app.js"]  

