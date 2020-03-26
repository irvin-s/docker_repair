# Builds a Docker image for Octave with Jupyter Notebook.  
#  
# It can be found at:  
# https://hub.docker.com/r/compdatasci/octave-notebook  
#  
# Authors:  
# Xiangmin Jiao <xmjiao@gmail.com>  
FROM compdatasci/base  
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"  
  
USER root  
WORKDIR /tmp  
  
# Install octave and octave_kernel  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
build-essential make \  
octave liboctave-dev \  
gnuplot-x11 \  
libopenblas-base libatlas3-base \  
ghostscript pstoedit && \  
pip install -U sympy && \  
octave --eval 'pkg install -forge struct parallel symbolic odepkg' && \  
pip3 install -U octave_kernel && \  
python3 -m octave_kernel.install && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
WORKDIR $DOCKER_HOME  

