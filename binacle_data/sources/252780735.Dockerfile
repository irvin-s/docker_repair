FROM node:6  
# Need Xvfb  
RUN apt-get update --yes  
RUN apt-get install --yes libgtk2.0-0 libnotify4 libgconf2-4 libnss3  
RUN apt-get install --yes xvfb  
  
# Need Cypress itself  
RUN npm set progress=false  
RUN npm i -g cypress-cli@0.11.1  
  
ARG CYPRESS_VERSION  
ENV CYPRESS_VERSION ${CYPRESS_VERSION:-0.17.4}  
RUN echo Cypress version to install $CYPRESS_VERSION  
RUN cypress install  
RUN cypress verify  

