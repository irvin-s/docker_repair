FROM ubuntu:latest  
MAINTAINER Storj Labs (bill@storj.io)  
  
RUN apt-get update && \  
apt-get -y install mongodb && \  
service mongodb start  
#apt-get -y install apt-utils curl && \  
#curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
#apt-get -y install build-essential git libssl-dev nodejs python vim && \  
#RUN npm install --global storj-bridge --unsafe-perm && \  
#NODE_ENV=develop storj-bridge  

