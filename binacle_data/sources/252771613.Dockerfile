FROM ubuntu:14.04  
RUN apt-get -y update -qq  
RUN apt-get install -y libgdal1h \  
gdal-bin \  
libgdal-dev \  
libgeos-dev \  
git-core \  
python-numpy \  
python-pip \  
gfortran \  
python-pycurl \  
python-dev  
ADD requirements.txt requirements.txt  
RUN pip install -r requirements.txt  
RUN pip install iron-worker>=1.3.1  

