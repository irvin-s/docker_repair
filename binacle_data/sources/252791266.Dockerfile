FROM docker:stable as dockerclient  
  
FROM maven:3-jdk-8-alpine  
RUN apk update && apk upgrade && \  
apk add \  
bash \  
git \  
procps \  
openssh \  
curl \  
less \  
groff \  
jq \  
python \  
py-pip \  
py2-pip && \  
pip install --upgrade pip awscli s3cmd && \  
mkdir /root/.aws  
COPY \--from=dockerclient /usr/local/bin/docker /usr/local/bin/docker  
  
  
  

