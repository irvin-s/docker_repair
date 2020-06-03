FROM ubuntu:14.04  
  
WORKDIR /opt  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y python && \  
apt-get install -y wget \  
curl \  
unzip \  
python-dev \  
python-setuptools \  
git \  
less \  
build-essential \  
gcc \  
zlib1g-dev \  
libncurses5-dev \  
python-numpy \  
python-biopython  
  
RUN git clone https://github.com/cgrlab/fusioncatcher.git;  
  
  

