# craneleeon/pynotebook  
FROM ubuntu:16.04  
# Pick up some dependencies  
RUN apt-get update && apt-get install -y --no-install-recommends \  
build-essential \  
curl \  
libfreetype6-dev \  
libpng12-dev \  
libzmq3-dev \  
pkg-config \  
python \  
python-dev \  
python-wheel \  
python-pip \  
python3 \  
python3-dev \  
python3-wheel \  
python3-pip \  
rsync \  
software-properties-common \  
unzip \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# RUN curl -O https://bootstrap.pypa.io/get-pip.py && \  
# python get-pip.py && \  
# rm get-pip.py  
  
RUN echo "alias python=python3" >> ~/.bashrc  
RUN echo "alias pip=pip3" >> ~/.bashrc  
  
RUN python3 -m pip install --upgrade pip setuptools \  
&& \  
python3 -m pip --no-cache-dir install \  
Pillow \  
h5py \  
ipykernel \  
jupyter \  
jupyter_contrib_nbextensions \  
jupyter_nbextensions_configurator \  
matplotlib \  
numpy \  
pandas  
  
RUN python2 -m pip install --upgrade pip setuptools \  
&& \  
python2 -m pip install ipykernel \  
matplotlib \  
numpy \  
&& \  
python2 -m ipykernel install --user  
  
RUN python3 -m ipykernel.kernelspec  
# Enable nbextention  
RUN jupyter contrib nbextension install --user  
  
# --- DO NOT EDIT OR DELETE BETWEEN THE LINES --- #  
# These lines will be edited automatically by parameterized_docker_build.sh. #  
# COPY _PIP_FILE_ /  
# RUN pip --no-cache-dir install /_PIP_FILE_  
# RUN rm -f /_PIP_FILE_  
# --- ~ DO NOT EDIT OR DELETE BETWEEN THE LINES --- #  
# Set up our notebook config.  
COPY jupyter_notebook_config.py /root/.jupyter/  
  
# Jupyter has issues with being run directly:  
# https://github.com/ipython/ipython/issues/7062  
# We just add a little wrapper script.  
COPY run_jupyter.sh /  
  
# IPython  
EXPOSE 8888  
  
WORKDIR "/notebooks"  
  
CMD ["/run_jupyter.sh", "--allow-root"]  

