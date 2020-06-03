FROM crazycode/buildpack-deps  
MAINTAINER crazycode  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Python.  
RUN \  
apt-get update && \  
apt-get install -y python python-dev python-pip python-virtualenv && \  
apt-get -qq clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Define working directory.  
WORKDIR /srv  
  
CMD ["bash"]  

