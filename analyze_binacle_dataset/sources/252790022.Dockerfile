FROM ubuntu:trusty  
MAINTAINER Hervé Bredin <bredin@limsi.fr>  
  
RUN apt-get update  
RUN apt-get install -y build-essential \  
wget \  
curl \  
git  
  
# Python  
RUN apt-get install -y python-pip \  
python-dev \  
python-numpy \  
python-scipy \  
python-numexpr  
  
# OpenCV  
RUN apt-get install -y libav-tools \  
libavcodec-extra-54 \  
libopencv-dev \  
python-opencv  
  
ADD . /code  
WORKDIR /code  
  
RUN pip install -r requirements.txt  

