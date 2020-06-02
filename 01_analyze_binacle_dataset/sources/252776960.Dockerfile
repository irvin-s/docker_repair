FROM node:latest  
  
RUN useradd -m app  
  
USER app  
WORKDIR /home/app  
  
ADD package.json /home/app/  
RUN npm install  
  
ADD src /home/app/src  
  
ENV ACTIVEMQ_USER publisher  
ENV ACTIVEMQ_PASSWORD publisher  
  
CMD node src/app.js  

