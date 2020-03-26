FROM nvidia/cuda:9.0-cudnn7-devel  
  
RUN apt-get update -y && \  
apt-get install -y --no-install-recommends \  
python3-dev \  
python3-pip && \  
rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*  
  
RUN ln -s /usr/bin/python3 /usr/local/bin/python && \  
ln -s /usr/bin/pip3 /usr/local/bin/pip  
  
RUN pip install --upgrade pip==9.0.1 && \  
pip install setuptools==38.2.4 && \  
pip install cupy==2.2.0 chainer==3.2.0

