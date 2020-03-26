#base image provides CUDA support on Ubuntu 16.04
FROM nvidia/cuda:9.0-cudnn7-devel

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV NB_USER keras
ENV NB_UID 1000

#package updates to support conda
RUN apt-get update && \
    apt-get install -y wget git libhdf5-dev g++ graphviz

#add on conda python and make sure it is in the path
RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet --output-document=anaconda.sh  https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh && \
    /bin/bash /anaconda.sh -f -b -p $CONDA_DIR && \
    rm anaconda.sh

#setting up a user to run conda
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown keras $CONDA_DIR -R && \
    mkdir -p /src && \
    chown keras /src

#conda installing python, then tensorflow and keras for deep learning
RUN conda install -y python=3.6 && \
    pip install --upgrade pip && \
    pip install tensorflow==1.9.0 && \
    pip install keras==2.2.0 && \
    conda clean -yt

#all the code samples for the video series
VOLUME ["/src"]

#serve up a jupyter notebook 
USER keras
WORKDIR /src
EXPOSE 8888
CMD jupyter notebook --port=8888 --ip=0.0.0.0
