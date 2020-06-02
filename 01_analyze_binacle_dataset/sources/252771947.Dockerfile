FROM centos:7  
MAINTAINER AttractGroup  
  
RUN yum update -y && yum clean all  
RUN yum install -y yum-utils  
RUN yum-config-manager --enable cr  
RUN yum install -y epel-release  
RUN yum install -y \  
python-pip \  
python-setuptools \  
nginx \  
gcc \  
gcc-c++ \  
python-devel \  
unzip \  
wget \  
git \  
supervisor \  
mysql-devel \  
libjpeg-devel \  
rabbitmq-server  
  
RUN pip install uwsgi  
  
# Set local IP  
RUN yum install -y iproute  
  
ADD ./req.txt /home/docker/code/req.txt  
# run pip install  
RUN pip install -r /home/docker/code/req.txt  

