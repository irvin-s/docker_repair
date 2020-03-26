FROM ubuntu:14.04  
MAINTAINER David Hunter <hello@dave-hunter.com>  
  
# Install git and iTorch dependencies  
RUN apt-get update && apt-get install -y \  
software-properties-common \  
git \  
wget \  
libzmq3-dev \  
libssl-dev \  
python-zmq  
  
WORKDIR /root  
  
# Torch7 installation scripts - http://torch.ch/docs/getting-started.html  
RUN git clone https://github.com/torch/distro.git torch --recursive && \  
cd torch && \  
bash install-deps && \  
./install.sh  
  
ENV PATH=/root/torch/install/bin:$PATH  
  
# Install miniconda  
ENV CONDA_DOWNLOAD_SCRIPT Miniconda3-latest-Linux-x86_64.sh  
ENV CONDA_DIR /opt/conda  
  
RUN wget -q https://repo.continuum.io/miniconda/$CONDA_DOWNLOAD_SCRIPT && \  
bash $CONDA_DOWNLOAD_SCRIPT -b -p $CONDA_DIR && \  
rm $CONDA_DOWNLOAD_SCRIPT  
  
ENV PATH $CONDA_DIR/bin:$PATH  
  
# Install jupyter  
RUN conda install -y jupyter  
  
# Install iTorch  
RUN git clone https://github.com/facebook/iTorch.git && \  
cd iTorch && \  
luarocks make  
  
WORKDIR /root/dev  
  
# Default command is to run the itorch-notebook  
CMD ["itorch", "notebook", "--ip=0.0.0.0", "--no-browser"]

