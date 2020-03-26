FROM ubuntu:xenial  
MAINTAINER Chris Hardekopf <chrish@basis.com>  
  
# Install duplicity from ppa  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
wget python python-dev python-pip librsync-dev \  
ncftp lftp rsync software-properties-common \  
libffi-dev libssl-dev && \  
add-apt-repository -y ppa:duplicity-team/ppa && \  
apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y duplicity && \  
rm -rf /var/lib/apt/lists/*  
  
# Make sure that all python requirements are installed  
ADD requirements.txt /opt/  
RUN pip install --upgrade --requirement /opt/requirements.txt  
  
# duplicity is the entry point  
ENTRYPOINT [ "/usr/bin/duplicity" ]  

