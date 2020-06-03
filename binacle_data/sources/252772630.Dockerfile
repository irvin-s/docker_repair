FROM ubuntu:trusty  
  
MAINTAINER Ben M, git@bmagg.com  
  
# Install packages  
RUN apt-get update && apt-get -yq install nodejs npm  
  
# Environment variables  
# Run npm install on startup (set as blank to not run e.g. `NPM_INSTALL=`)  
ENV NPM_INSTALL=true  
  
# Run a nodejs script on startup (set as blank to not run anything)  
ENV RUN_SCRIPT=index.js  
  
# Choose a port to run on  
ENV NODE_SCRIPT_PORT=3000  
# Add run script  
ADD run.sh /run.sh  
  
# Mount volume  
VOLUME /app  
WORKDIR /app  
  
EXPOSE $NODE_SCRIPT_PORT  
CMD ["/run.sh"]

