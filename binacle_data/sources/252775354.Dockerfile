FROM ubuntu:14.04  
MAINTAINER Behance Ops <devops-behance@adobe.com>  
  
RUN apt-get update && \  
apt-get -yq install \  
python python-dev libssl-dev autoconf g++ python-pip zip git jq \  
&& pip install awscli  
  
RUN mkdir /app/  
  
COPY . /app/  
RUN pip install -r /app/requirements.txt  
  
# Perform cleanup, ensure unnecessary packages are removed  
RUN apt-get autoclean -y && \  
apt-get autoremove -y && \  
rm -rf /tmp/* /var/tmp/* && \  
rm -rf /var/lib/apt/lists/*  

