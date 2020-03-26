FROM ubuntu:16.04  
  
#Set Maintainer  
MAINTAINER Chris Baptista  
  
# Set Working Directory  
WORKDIR /opt  
  
# Update apt-get  
RUN apt-get update  
  
# Install essentials  
RUN apt-get install -y build-essential  
  
# Install node js and npm  
RUN apt-get install -y nodejs npm \  
&& ln -s `which nodejs` /usr/bin/node  
  
# Clear apt-get cache  
RUN apt-get clean  
  
# Install npm nodules  
RUN npm install --silent -g gulp bower  
  
# Create npm cache that's writable to all users  
RUN mkdir /tmp/.npm \  
&& chmod -R 777 /tmp/.npm \  
&& npm config set cache /tmp/.npm --global  
  
# Set volumes  
VOLUME ["/opt"]  
  
# Set default command  
CMD ["gulp", "build"]  
  

