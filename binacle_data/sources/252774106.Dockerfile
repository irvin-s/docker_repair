FROM ubuntu:14.04  
MAINTAINER Paolo Veglia  
USER root  
  
# RUN echo "Acquire::http::No-Cache true;\nAcquire::http::Pipeline-Depth 0;" \  
# > /etc/apt/apt.conf.d/80http  
ADD https://deb.nodesource.com/setup_4.x /tmp/  
RUN bash /tmp/setup_4.x  
  
# add node.js repository key  
RUN apt-get update && apt-get upgrade -y \  
&& apt-get install -y \  
build-essential \  
curl \  
fontconfig \  
git \  
htop \  
libffi-dev \  
libfreetype6 \  
libjpeg-dev \  
libldap2-dev \  
libmysqlclient-dev \  
libpq-dev \  
libsasl2-dev \  
libxml2-dev \  
libxslt1-dev \  
nodejs \  
nginx \  
python \  
python-apt \  
python-dev \  
python-virtualenv \  
supervisor \  
swig \  
tmux \  
vim \  
xsel \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD https://bootstrap.pypa.io/get-pip.py /tmp/  
RUN python /tmp/get-pip.py  
  
# python requirements  
RUN mkdir /code  
ADD requirements*.txt package.json /code/  
RUN pip install -r /code/requirements-dev.txt --ignore-installed  
  
RUN npm install -g npm && cd /code && npm install  

