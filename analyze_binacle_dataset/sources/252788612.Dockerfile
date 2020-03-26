FROM ubuntu:16.04  
WORKDIR /root/  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \  
curl \  
python \  
python-dev \  
software-properties-common && \  
curl https://bootstrap.pypa.io/get-pip.py | python && \  
apt-get autoremove --assume-yes && \  
apt-get clean && \  
rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*  
RUN add-apt-repository -y ppa:ubuntugis/ppa && \  
apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \  
gdal-bin \  
libgdal-dev \  
python-gdal \  
python-opencv && \  
apt-get autoremove --assume-yes && \  
apt-get clean && \  
rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*  
COPY requirements.txt /tmp/  
RUN pip install -r /tmp/requirements.txt && \  
rm --force /tmp/requirements.txt  
COPY . /root/  

