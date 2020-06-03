FROM node  
MAINTAINER Daniele Moraschi "daniele.moraschi@gmail.com"  
# Install Bower & Grunt  
RUN npm install -g bower grunt-cli  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

