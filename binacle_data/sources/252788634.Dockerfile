FROM python:3.5.1-alpine  
MAINTAINER Chris Smith <chris87@gmail.com>  
  
RUN \  
pip install \  
python-etcd==0.4.3  
  
COPY etcdlib.py /  

