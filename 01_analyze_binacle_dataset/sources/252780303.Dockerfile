#  
# Python Dockerfile  
#  
# https://github.com/dockerfile/python  
#  
# Pull base image.  
FROM dockerfile/ubuntu  
  
# Install Python.  
RUN apt-get install -y python python-dev python-pip python-virtualenv  
  
# Install pandoc  
RUN apt-get install -y pandoc pandoc-citeproc  
  
# Define mountable directories.  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

