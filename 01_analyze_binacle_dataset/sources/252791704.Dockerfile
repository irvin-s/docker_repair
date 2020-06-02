FROM postgres:9.6  
MAINTAINER Dale  
  
RUN apt-get update -y \  
&& apt-get autoremove -y \  
&& apt-get install \  
python-pip \  
python2.7-dev \  
build-essential \  
libpq-dev \  
zlib1g-dev \  
vim \  
-y \  
&& pip install --upgrade pip  

