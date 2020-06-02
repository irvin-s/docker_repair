FROM ubuntu:14.04  
  
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales  
ENV LANG en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
  
RUN apt-get update; apt-get -y upgrade; apt-get clean; \  
apt-get install -y \  
build-essential \  
curl \  
cmake \  
expect \  
git \  
unzip \  
pkg-config \  
tree \  
jq \  
language-pack-en \  
libxslt-dev \  
libxml2-dev \  
libssl-dev \  
libreadline6 \  
libreadline6-dev \  
libyaml-dev \  
openssl \  
python \  
python-pip \  
python-dev \  
python-setuptools \  
python-software-properties \  
language-pack-en \  
mysql-client \  
wget \  
; \  
apt-get clean  
  
RUN pip install awscli  
  
ADD assets/config ~/.ssh/config  

