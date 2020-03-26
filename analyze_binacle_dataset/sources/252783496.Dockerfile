FROM alpine:3.7  
MAINTAINER Decibel Automation Team <devops@thedecibelgroup.com>  
  
RUN apk add --no-cache \  
openssl-dev \  
libffi-dev \  
py-pip \  
py-jinja2 \  
yaml-dev \  
python-dev \  
gcc \  
make \  
musl-dev \  
mysql-client  
RUN pip install --upgrade setuptools  
RUN pip install ansible==2.4.4.0  

