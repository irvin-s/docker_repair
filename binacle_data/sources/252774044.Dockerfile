FROM alpine:3.4  
MAINTAINER Ecometrica <>  
  
ENV LANG C  
  
RUN apk add --no-cache bash git mercurial python py-pip openssh  
  
ADD . /concourse-bitbucket-resource  
  
RUN pip install -r /concourse-bitbucket-resource/requirements.txt  
  
RUN cd /concourse-bitbucket-resource && PYTHONPATH=. py.test  
  
ADD scripts /opt/resource

