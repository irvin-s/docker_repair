FROM node:6  
MAINTAINER David M. Lee, II <leedm777@yahoo.com>  
  
RUN npm install -g bunyan  
ENTRYPOINT ["bunyan"]  

