FROM node:7.4.0-alpine  
  
MAINTAINER David Finch  
  
ENV SAILSJS=_VERSION=latest  
  
ONBUILD RUN npm install sails:${SAILSJS_VERSION} -g \  
&& npm install grunt-cli -g \  
&& sails new app  
  
CMD sails lift app  
  
EXPOSE 1337  
EXPOSE 8080

