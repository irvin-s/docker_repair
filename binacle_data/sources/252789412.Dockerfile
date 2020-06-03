FROM node:6  
RUN npm install -g bower  
RUN npm install -g ember-cli  
RUN npm install -g phantomjs-prebuilt  
  
CMD ["tail", "-f", "/dev/null"]  

