FROM debian:stretch  
MAINTAINER Bastien Durel bastien.docker@durel.org  
COPY locale.gen /etc/locale.gen  
ENV LANG=en_US.UTF-8  
RUN apt update ; DEBIAN_FRONTEND=noninteractive apt -q -y upgrade ; \  
DEBIAN_FRONTEND=noninteractive apt install -q -y \  
build-essential \  
bzip2 \  
cmake \  
curl \  
debhelper \  
dpkg-dev \  
g++ \  
git \  
libboost-all-dev \  
libicu-dev \  
libexpat1-dev \  
libluabind-dev \  
libluajit-5.1-dev \  
default-libmysqlclient-dev \  
libprotobuf-dev \  
libsqlite3-dev \  
libxerces-c-dev \  
libzmq3-dev \  
locales \  
lua-json \  
make \  
openjdk-8-jdk \  
openjdk-8-jre-headless \  
pkg-config \  
python-minimal \  
wget \  
&& apt-get clean  

