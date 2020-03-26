FROM cypress/base:10  
MAINTAINER Marc Rosenthal <marc@affordabletours.com>  
  
RUN npm install --save-dev cypress  
RUN $(npm bin)/cypress verify  

