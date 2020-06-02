FROM debian:jessie  
  
MAINTAINER Alessandro Resta <alessandro.resta@gmail.com>  
  
RUN \  
apt-get update && \  
apt-get install -y \  
python \  
python-dev \  
python-distribute \  
python-pip  
  
RUN pip install \  
pytest \  
pytest-cov  
  
COPY . usr/src/python-exercises/  
  
WORKDIR usr/src/python-exercises  

