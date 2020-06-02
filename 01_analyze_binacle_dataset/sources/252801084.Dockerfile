FROM node:8.7.0-alpine  
  
COPY . /app/  
  
WORKDIR /app  
  
EXPOSE 80 443  
RUN npm i  
  
CMD ["npm", "run", "prod"]

