FROM dpatriot/docker-s3-runner:1.4.0  
MAINTAINER Shago Vyacheslav <v.shago@corpwebgames.com>  
  
ADD requirements.txt /opt/  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# enable the universe  
RUN sed -i 's/^#\s*\\(deb.*universe\\)$/\1/g' /etc/apt/sources.list  
RUN apt-get -y update && apt-get install -y \  
mysql-client \  
gfortran \  
libopenblas-dev \  
liblapack-dev \  
libmysqlclient* \  
libtiff5-dev \  
libjpeg8-dev \  
zlib1g-dev \  
libfreetype6-dev \  
libpq-dev \  
libxft-dev \  
pkg-config \  
python2.7 \  
python-dev \  
python-pip \  
tmux \  
curl \  
nano \  
vim \  
git \  
htop \  
man \  
software-properties-common \  
unzip \  
wget \  
libncurses5-dev \  
readline-common  
  
RUN apt-get build-dep -y python-matplotlib  
  
RUN pip install -r /opt/requirements.txt && \  
pip install --pre xgboost && \  
pip install certifi==2015.04.28  
  
RUN rm -rf /var/lib/apt/lists/*  

