FROM ubuntu:trusty  
  
MAINTAINER Diana Soares <diana.soares@gmail.com>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade \  
&& DEBIAN_FRONTEND=noninteractive apt-get update \  
&& apt-get -y install software-properties-common \  
&& add-apt-repository ppa:fkrull/deadsnakes  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update \  
&& apt-get -y install \  
make \  
python2.7 \  
python-pip \  
python-dev \  
python3.5 \  
python3-pip \  
python3.5-dev \  
python-virtualenv  

