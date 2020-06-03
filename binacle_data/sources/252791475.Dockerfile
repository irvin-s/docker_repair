FROM alpine:3.7  
MAINTAINER dadez <dadez@protonmail.com>  
  
#override proxy settings  
ENV http_proxy=""  
ENV https_proxy=""  
# Install tooling  
RUN apk add --update \  
ca-certificates \  
#git \  
python3 \  
python3-dev \  
py3-netifaces \  
build-base \  
libffi-dev \  
openssl-dev \  
# install powerseal  
&& pip3 install powerfulseal \  
&& pip3 install os-client-config  
  
  
# Remove obsolete packages  
RUN apk del \  
python3-dev \  
build-base \  
openssl-dev \  
libffi-dev  
  
# Clean caches and tmps  
RUN rm -rf /var/cache/apk/* \  
/tmp/* \  
/var/log/*  

