FROM ashdev/docker-nodejs:v4.2.2  
MAINTAINER AshDev <ashdevfr@gmail.com>  
  
RUN npm install -g node-gyp  
RUN npm install -g gulp  
RUN npm install -g grunt-cli  
RUN npm install -g bower  
RUN npm install -g nodemon  
RUN npm install -g protractor  
RUN npm install -g phantomjs  

