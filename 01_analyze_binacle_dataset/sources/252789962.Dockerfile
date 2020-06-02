FROM python:2.7-slim  
  
RUN apt-get -y update  
RUN apt-get install -y --fix-missing \  
build-essential \  
cmake \  
gfortran \  
git \  
wget \  
curl \  
graphicsmagick \  
libgraphicsmagick1-dev \  
libatlas-dev \  
libavcodec-dev \  
libavformat-dev \  
libboost-all-dev \  
libgtk2.0-dev \  
libjpeg-dev \  
liblapack-dev \  
libswscale-dev \  
pkg-config \  
python-dev \  
python-numpy \  
python-protobuf\  
software-properties-common \  
zip \  
&& apt-get clean && rm -rf /tmp/* /var/tmp/*  
  
RUN cd ~ && \  
mkdir -p dlib && \  
git clone https://github.com/davisking/dlib.git dlib/ && \  
cd dlib/ && \  
python setup.py install --yes USE_AVX_INSTRUCTIONS  

