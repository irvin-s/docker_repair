FROM node:slim  
  
ADD . /gla-sails  
RUN cd /gla-sails; npm install  
  
WORKDIR /gla-sails  
  
EXPOSE 1337  
CMD ["npm", "start"]  

