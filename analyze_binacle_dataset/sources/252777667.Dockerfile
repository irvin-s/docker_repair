FROM centos:7  
MAINTAINER Oliver Tupman <oliver@dts-workshop.com>  
ENV CFY_VERISON 3.4.0  
  
RUN yum install -y python && \  
yum install -y python-devel  
  
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \  
python get-pip.py && \  
pip install virtualenv && \  
yum install -y pycrypto  
  
ENV CFY_VERSION=3.4.0  
RUN pip install cloudify==$CFY_VERSION && \  
pip install wagon  

