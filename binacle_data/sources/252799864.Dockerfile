#  
# Node.js w/ Bower & Grunt Dockerfile  
#  
# https://github.com/digitallyseamless/docker-nodejs-bower-grunt  
#  
# Pull base image.  
FROM library/node:5  
MAINTAINER Digitally Seamless <docker@digitallyseamless.com>  
  
# Install Bower & Grunt  
RUN npm install -g bower grunt-cli && \  
echo '{ "allow_root": true }' > /root/.bowerrc  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

