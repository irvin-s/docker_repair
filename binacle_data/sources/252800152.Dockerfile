# Description:  
#  
# Package haxe and some useful nodejs build utils such as  
# - chokidar-cli  
# - nodemon  
# - webpack  
# - browserify  
# in the same image so you can run haxe builds automatically triggered  
# by code changes, and then run the server  
#  
  
FROM haxe:3.4.4-stretch  
MAINTAINER dion@transition9.com  
  
ENV SHELL=/bin/bash  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -y nodejs rsync jq curl make g++ gcc && \  
npm install -g chokidar-cli nodemon webpack-cli browserify && \  
rm -rf /var/lib/apt/lists/*  

