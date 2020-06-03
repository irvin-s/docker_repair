FROM ubuntu:14.04  
  
# Install packages  
RUN apt-get update && \  
apt-get install -y \  
build-essential gfortran liblapack-dev libblas-dev \  
python3 python3-dev python3-pip python3-matplotlib python3-setuptools\  
ranger tmux \  
git cmake  
  
RUN apt-get install python3-setuptools  
  
RUN apt-get purge python2.7-minimal -y  
  
RUN ln -sf /bin/bash /bin/sh  
  
# RUN source /root/.bashrc  
RUN pip3 install matplotlib ipython pandas scipy sklearn  
RUN pip3 install jupyter mkdocs

