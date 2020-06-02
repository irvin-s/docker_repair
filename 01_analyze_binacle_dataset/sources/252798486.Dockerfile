FROM node:7.5-alpine  
  
MAINTAINER dentych  
  
ADD . /nodeapp/  
  
WORKDIR /nodeapp  
  
EXPOSE 3000  
CMD ["./start.sh"]  

