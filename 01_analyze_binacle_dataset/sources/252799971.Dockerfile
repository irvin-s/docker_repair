FROM alpine:3.3  
MAINTAINER Dimitry Butyrin <dimitri.butyrin@brain-agency.com>  
# based on https://github.com/xueshanf/docker-awscli  
  
RUN apk --update add \  
bash \  
curl \  
less \  
groff \  
jq \  
python \  
py-pip && \  
pip install --upgrade awscli s3cmd awsebcli && \  
mkdir /root/.aws  

