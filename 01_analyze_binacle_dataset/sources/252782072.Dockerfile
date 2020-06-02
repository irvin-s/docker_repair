FROM node  
  
RUN npm install html-minifier -g  
  
CMD [ "html-minifier", "--help" ]  

