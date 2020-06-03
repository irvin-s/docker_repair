FROM node:boron  
  
RUN set -ex \  
&& apt-get update \  
&& apt-get install -y \  
python-setuptools \  
python-dev \  
&& easy_install pip \  
&& pip install awscli  
  
USER node  

