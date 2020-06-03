FROM debian:wheezy  
MAINTAINER cocoon  
  
  
  
  
RUN apt-get update  
  
# install git  
RUN apt-get install -yq git-core  
  
# install vim  
RUN apt-get install -yq vim  
ADD files/vimrc /.vimrc  
  
# Install Python.  
RUN \  
apt-get update && \  
apt-get install -y python python-dev python-pip python-virtualenv && \  
rm -rf /var/lib/apt/lists/*  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

