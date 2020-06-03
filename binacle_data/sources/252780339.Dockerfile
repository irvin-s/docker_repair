FROM node:9-alpine  
WORKDIR /app  
COPY . /app  
  
EXPOSE 3000  
ENV DEBUG acr-patch-sample-web:*  
CMD ["npm","start" ]  

