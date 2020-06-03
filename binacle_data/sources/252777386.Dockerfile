FROM ubuntu:14.04  
WORKDIR /opt  
  
RUN apt-get update && apt-get install -y \  
libcurl4-gnutls-dev \  
libgnutls-dev \  
python \  
python-pip \  
python-dev \  
build-essential \  
libncurses5-dev \  
libncursesw5-dev \  
pypy \  
git  
  
RUN pip install --upgrade pip  
RUN pip install --upgrade virtualenv  
  
RUN git clone https://github.com/cgrlab/MapSplice2.git  
  
RUN cd /opt/MapSplice2; make  
  

