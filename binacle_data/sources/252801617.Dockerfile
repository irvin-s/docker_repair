FROM node:slim  
  
MAINTAINER Eric Biven <eric@biven.us>  
  
RUN npm install --quiet --global \  
bower \  
coffee-script \  
frisby \  
gulp \  
jasmine-node  
WORKDIR /Workspace  

