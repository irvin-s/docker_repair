FROM ubuntu:16.04  
  
RUN apt-get update  
RUN apt-get install -yq python3-pip python3-numpy  
RUN apt-get install -yq nodejs npm  
RUN apt-get clean  
  
RUN apt-get install -yq firefox  
RUN apt-get install -yq xvfb  
  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
RUN pip3 install invoke  
RUN npm install -g jshint  

