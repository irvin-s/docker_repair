#  
# python3-base: Sets up a boilerplate Docker environment for NVIDIA CUDA with  
# Python 3 and OpenBLAS. The main use of this Dockerfile is as an intermediate  
# step for setting up scientific frameworks with Python.  
#  
# Base image is cuda-base  
FROM aleksaro/cuda-base:9.0-cudnn7-ubuntu16.04  
  
LABEL maintainer "Aleksander Rognhaugen"  
# Install basic packages and miscellaneous dependencies  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \  
liblapack-dev \  
libopenblas-dev \  
libzmq3-dev \  
python3 \  
python3-dev \  
python3-pip \  
python3-setuptools \  
python3-tk  
  
  
# Install Pillow (PIL) dependencies  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \  
libfreetype6-dev \  
libjpeg-dev \  
liblcms2-dev \  
libopenjpeg-dev \  
libpng12-dev \  
libtiff5-dev \  
libwebp-dev \  
zlib1g-dev  
  
  
# Cleanup apt-get  
RUN apt-get clean && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/*  
  
  
# Upgrade pip and setuptools  
RUN pip3 install --upgrade \  
setuptools \  
pip  
  
  
# Install basic Python packages (some of these may already be installed)  
RUN pip3 install \  
wheel \  
six \  
Cython \  
nose \  
ipython \  
jupyter \  
ipdb \  
numpy \  
Pillow \  
imageio \  
scipy \  
matplotlib  
  
  
# Prepare matplotlib font cache  
RUN python3 -c "import matplotlib.pyplot"  
# Add alias to `.bash_aliases` so that `python` runs `python3`  
RUN echo "alias python=python3" \  
>> /root/.bash_aliases  
  
  
# Set default working directory and image startup command  
WORKDIR "/root"  
CMD ["/bin/bash"]  

