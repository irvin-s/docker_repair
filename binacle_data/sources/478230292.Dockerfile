FROM tensorflow/tensorflow:1.2.1-gpu

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install -y \
    python-scipy \
    python-numpy \
    python-imaging \
    git
    
RUN pip install h5py \
                progressbar \
                colorlog \
                imageio
                 
WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]




