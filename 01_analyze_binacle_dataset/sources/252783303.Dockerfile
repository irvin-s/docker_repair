FROM debian:testing  
MAINTAINER Diego Diez <diego10ruiz@gmail.com>  
  
ENV VERSION=v2.0.9  
## Install MACS.  
RUN apt-get update && \  
apt-get install -y git && \  
apt-get install -y python2.7 python-numpy cython && \  
cd /tmp && git clone https://github.com/taoliu/MACS.git && \  
cd MACS && git checkout $VERSION && \  
python setup.py install --prefix /opt && \  
cd /tmp && rm -rf MACS && \  
apt-get clean -y && \  
apt-get purge -y cython git libpython2.7-dev libpython-dev && \  
apt-get autoremove -y  
  
## Set up environment.  
# Variables.  
ENV PATH /opt/bin:$PATH  
ENV PYTHONPATH /opt/lib/python2.7/site-packages:$PYTHONPATH  
  
# User.  
RUN useradd -ms /bin/bash biodev  
RUN echo 'biodev:biodev' | chpasswd  
USER biodev  
WORKDIR /home/biodev  

