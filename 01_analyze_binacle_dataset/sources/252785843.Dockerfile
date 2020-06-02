FROM node:0.10  
  
ENV PORT 8080  
EXPOSE 8080  
  
ADD . /app  
WORKDIR /app  
RUN npm install  
  
CMD ["node","app.js"]

