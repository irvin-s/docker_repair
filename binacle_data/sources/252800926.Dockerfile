FROM ubuntu:14.04  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install required packages  
RUN apt-get update -q && \  
apt-get install -qy \  
git \  
vim \  
build-essential \  
python-dev \  
python3-dev \  
python-pip \  
python3-pip\  
curl \  
wget \  
locate \  
apt-transport-https  
  
# Clean up APT when done.  
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# It's a dev playground so keep the apt lists  
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*  

