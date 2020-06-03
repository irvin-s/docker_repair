FROM node:7.9  
  
MAINTAINER aaa  
  
RUN npm install -g @angular/cli  
  
EXPOSE 4200  
  
CMD tail -f /dev/null  

