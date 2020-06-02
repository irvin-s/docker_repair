#  
# Dockerfile for newman 2.1.2  
#  
FROM node:4.4.7  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
COPY . /etc/newman  
  
WORKDIR /etc/newman  
  
#RUN npm install -g newman@2.1.2  
RUN npm install -g grunt-cli  
RUN npm install -g  
  
ENTRYPOINT ["newman"]  

