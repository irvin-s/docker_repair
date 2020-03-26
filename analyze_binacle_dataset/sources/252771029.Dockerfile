# based off nodejs docker image  
FROM node:6-slim  
MAINTAINER bitttttten <https://github.com/bitttttten>  
  
# first add package.json for diff  
ADD package.json /src/package.json  
  
RUN cd /src && \  
npm install  
  
# now expose on port 6000  
EXPOSE 6000

