FROM ubuntu:14.04  
RUN apt-get update && \  
apt-get build-dep -y python-numpy python-scipy && \  
apt-get install -y \  
python-pip \  
python-dev \  
liblapack3 \  
liblapack-dev \  
libatlas-dev \  
libatlas3-base \  
libblas3 \  
libblas-dev \  
git \  
gfortran && \  
rm -rf /var/lib/apt/lists/*  
  
ADD requirements.txt /  
  
RUN pip install -r requirements.txt  
  
WORKDIR /src  
  
COPY src/ /src/  
  
ENTRYPOINT [ "/src/main.py" ]  

