FROM ubuntu  
  
RUN apt-get update; \  
apt-get install -y \  
python python-pip \  
python-numpy python-scipy \  
build-essential python-dev python-setuptools \  
libatlas-dev libatlas3gf-base  
  
RUN update-alternatives --set libblas.so.3 \  
/usr/lib/atlas-base/atlas/libblas.so.3; \  
update-alternatives --set liblapack.so.3 \  
/usr/lib/atlas-base/atlas/liblapack.so.3  
  
RUN pip install -U scikit-learn  

