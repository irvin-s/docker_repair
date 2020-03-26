FROM node:0.12.4  
RUN npm install -g protractor; \  
webdriver-manager update; \  
npm install jasmine-reporters@~1.0.0;  
  

