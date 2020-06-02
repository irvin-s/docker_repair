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
nodejs \  
npm \  
git \  
supervisor \  
mysql-devel \  
openssl-devel \  
iproute \  
rabbitmq-server && \  
pip install uwsgi  
  
# Set local IP  
RUN yum install -y iproute  
  
EXPOSE 80 8000  

