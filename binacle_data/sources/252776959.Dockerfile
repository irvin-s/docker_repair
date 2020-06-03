FROM node:latest  
  
RUN useradd -m app  
  
USER app  
WORKDIR /home/app  
  
ADD package.json /home/app/  
RUN npm install  
  
ADD src /home/app/src  
  
ENV ACTIVEMQ_USER subscriber  
ENV ACTIVEMQ_PASSWORD subscriber  
  
CMD node src/app.js  

