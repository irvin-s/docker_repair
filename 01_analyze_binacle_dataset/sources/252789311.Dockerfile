FROM node:latest  
  
RUN mkdir /usr/src/app  
COPY . /usr/src/app  
  
RUN cd /usr/src/app && npm install  
  
WORKDIR /usr/src/app  
  
EXPOSE 8000  
CMD ["npm", "start"]  

