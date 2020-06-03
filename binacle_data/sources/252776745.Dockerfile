FROM nvidia/cuda:7.5-cudnn5-devel  
MAINTAINER Cliff L. Biffle <code@cliffle.com>  
  
COPY tensorflow-0.9.0-cp27-none-linux_x86_64.whl /tmp  
  
RUN \  
apt-get update && \  
apt-get install -y --force-yes libcudnn5=5.0.5-1+cuda7.5 && \  
apt-get install -y \  
libcuda1-352 \  
python-dev \  
python-h5py \  
python-matplotlib \  
python-pip \  
python-scipy \  
python-sklearn \  
&& \  
rm -rf /var/lib/apt/lists/* && \  
pip install /tmp/tensorflow-0.9.0-cp27-none-linux_x86_64.whl && \  
pip install jupyter && \  
mkdir -p /notebooks  
  
EXPOSE 8888  
CMD jupyter notebook --notebook-dir=/notebooks --no-browser --ip=0.0.0.0  

