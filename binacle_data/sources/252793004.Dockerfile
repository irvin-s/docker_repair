# 1 step, build base  
# Authors:  
# Qiao Chen  
  
FROM ams529/desktop:latest  
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"  
  
USER root  
WORKDIR /tmp  
  
  
ENV LD_LIBRARY_PATH=$PETSC_DIR/lib:$LD_LIBRARY_PATH  
  
RUN apt-get update && apt-get upgrade -y && \  
apt-get install -y --no-install-recommends \  
python3-pyqt4 \  
libxt-dev \  
libtbb-dev \  
libfreeimage-dev \  
libgl2ps-dev \  
tk-dev \  
libxmu-dev \  
libsuitesparse-dev \  
gfortran && \  
apt-get clean && \  
pip3 install --upgrade --no-cache-dir \  
setuptools \  
numpy \  
scipy && \  
pip3 install --no-cache-dir \  
cython \  
pymetis \  
tables \  
pyparsing \  
pyface \  
pyamg && \  
pip3 install --no-cache-dir \  
git+https://github.com/scikit-umfpack/scikit-umfpack.git && \  
pip3 install --no-cache-dir \  
https://bitbucket.org/dalcinl/igakit/get/default.tar.gz && \  
rm -rf /var/lib/apt/lists/* /tmp/*  
  
WORKDIR $DOCKER_HOME  
USER root  

