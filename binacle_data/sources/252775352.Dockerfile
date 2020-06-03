FROM node:5  
ADD ./ /home/sinopia  
  
RUN cd /home/sinopia && npm install  
  
CMD cd /home/sinopia && ./bin/sinopia --listen 0.0.0.0:4873  

