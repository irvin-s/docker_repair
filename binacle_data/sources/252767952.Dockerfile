FROM node:6.12-alpine  
  
MAINTAINER Acumen dev team <acumendev1@gmail.com>  
  
ENV SERVERLESS_VERSION 1.12.1  
  
RUN apk --update add \  
git \  
python \  
py-pip \  
jq \  
&& pip install awscli==1.14.70 \  
&& apk del py-pip \  
&& rm -rf /var/cache/apk/* \  
&& npm install \  
cfn-create-or-update@1.1.2 \  
serverless@${SERVERLESS_VERSION} \  
-g  

