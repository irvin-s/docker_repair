FROM frolvlad/alpine-bash  
  
MAINTAINER Anas Ameziane <anasdox@gmail.com>  
  
RUN apk --update add \  
git \  
openssh \  
python \  
python-dev \  
py-setuptools \  
py-crypto \  
py2-pip \  
py-cparser \  
py-cryptography \  
py-markupsafe \  
py-cffi \  
py-yaml \  
py-jinja2 \  
py-paramiko \  
&& pip install --upgrade pip \  
&& hash -r \  
&& pip install --no-cache-dir ansible \  
&& chmod 750 /usr/bin/ansible* \  
# Cleanup  
&& apk del python-dev \  
&& rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  

