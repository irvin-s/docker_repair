FROM node:0.10  
MAINTAINER Alexander Harding <alexander.harding@software.dell.com>  
  
RUN apt-get update && \  
apt-get install -y vim ruby-full rubygems && \  
gem install compass && \  
npm install -g bower grunt  
  
ADD . /code  
WORKDIR /code  
  
RUN npm install && \  
bower install --allow-root  
  
EXPOSE 9000  
CMD npm start

