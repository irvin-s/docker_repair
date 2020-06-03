FROM node:6  
  
ADD . /home/service  
  
RUN cd /home/service && npm install  
  
CMD cd /home/service && node src/service.js

