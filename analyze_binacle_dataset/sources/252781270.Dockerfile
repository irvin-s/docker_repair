FROM alpine  
MAINTAINER Antonelli  
  
RUN apk --no-cache add \  
bash \  
less \  
groff \  
curl \  
python \  
py-pip \  
python-dev \  
build-base \  
libffi-dev \  
openssl-dev &&\  
pip install --upgrade pip \  
credstash  
  
  
ENV PAGER="less"  
# Expose credentials volume  
RUN mkdir ~/.aws

