# Description:  
#  
# Livereload server https://github.com/nitoyon/livereloadx  
#  
  
FROM node:8  
MAINTAINER dion@transition9.com  
  
RUN apt-get install -y make g++ gcc python && \  
npm install -g livereloadx && \  
rm -rf /var/lib/apt/lists/*  
  
EXPOSE 35729  

