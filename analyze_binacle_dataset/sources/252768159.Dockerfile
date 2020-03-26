FROM dockerfile/nodejs-bower-grunt  
RUN apt-get -y update  
RUN apt-get -y install ruby ruby-dev make  
RUN gem install compass  
  
ONBUILD ADD .bowerrc /app/  
ONBUILD ADD package.json /app/  
ONBUILD RUN npm install  
ONBUILD ADD bower.json /app/  
ONBUILD RUN bower install --allow-root -F  
ONBUILD ADD . /app  
ONBUILD RUN grunt build  
  
WORKDIR /app  

