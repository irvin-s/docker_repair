FROM node  
ADD . /app  
WORKDIR /app  
RUN npm install  
CMD node server  
EXPOSE 3000  
  

