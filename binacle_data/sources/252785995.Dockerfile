FROM node  
  
MAINTAINER Dermot Kilroy  
  
ADD . /var/www  
  
WORKDIR /var/www  
  
RUN npm install  
  
CMD ["npm", "start"]  

