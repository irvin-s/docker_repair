FROM node:argon  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY . /app  
EXPOSE 80  
CMD ["npm", "start"]  

