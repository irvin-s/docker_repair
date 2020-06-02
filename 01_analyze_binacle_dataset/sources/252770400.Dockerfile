FROM node:0.10-onbuild  
MAINTAINER Adam Simpson <simpsonadam@gmail.com>  
  
WORKDIR /opt  
ADD ./ /opt  
  
RUN npm install  
  
CMD ["node", "src/main.js"]  

