FROM node:6  
  
RUN apt-get update && apt-get install -y ruby-full  
RUN gem install sass compass  
RUN npm install -g grunt-cli bower yo generator-karma generator-angular  
RUN npm install karma karma-jasmine karma-chrome-launcher  
RUN npm install -g karma-cli  
  
USER node  

