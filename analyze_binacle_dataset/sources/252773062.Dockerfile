FROM node:0.12.0-slim  
  
RUN mkdir /server  
WORKDIR /server  
ADD . /server  
  
RUN cd /server; npm install  
  
# Expose ports.  
EXPOSE 1337  
  
CMD ["node", "app.js"]  

