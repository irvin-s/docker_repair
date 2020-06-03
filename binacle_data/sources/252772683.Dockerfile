FROM node:slim  
MAINTAINER Markus Benning <ich@markusbenning.de>  
  
RUN npm install -g \  
grunt-cli \  
&& rm -r ~/.npm  
  
ADD package.json /opt/grunt-live-server/package.json  
WORKDIR /opt/grunt-live-server  
  
RUN npm install \  
&& rm -r ~/.npm  
  
ADD Gruntfile.js /opt/grunt-live-server/Gruntfile.js  
ADD index.html /web/index.html  
  
EXPOSE 8000 35729  
CMD [ "grunt", "serve" ]  
  

