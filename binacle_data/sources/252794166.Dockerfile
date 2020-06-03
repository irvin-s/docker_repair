FROM stackbrew/ubuntu:saucy  
  
RUN apt-get update  
RUN apt-get -y install nodejs npm git  
RUN ln -s /usr/bin/nodejs /usr/bin/node

