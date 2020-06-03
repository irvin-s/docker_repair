FROM node:0.12-onbuild  
RUN npm install -g bower gulp  
  
RUN bower install --allow-root  
  
RUN gulp build  
  
EXPOSE 3000  

