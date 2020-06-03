FROM node:8.9-alpine  
  
MAINTAINER Acumen dev team <acumendev1@gmail.com>  
  
RUN apk --update add \  
git \  
python \  
py-pip \  
jq \  
&& pip install awscli==1.14.17 \  
&& apk del py-pip \  
&& rm -rf /var/cache/apk/* \  

