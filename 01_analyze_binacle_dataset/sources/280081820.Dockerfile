#base image provides CUDA support on Ubuntu 16.04
FROM nvidia/cuda:8.0-cudnn6-devel

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
    wget --quiet --output-document=miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash /miniconda.sh -f -b -p $CONDA_DIR && \
    rm miniconda.sh

#setting up a user to run conda
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown keras $CONDA_DIR -R && \
    mkdir -p /src && \
    chown keras /src

#all the code, including the ./var/data
COPY . /mailscanner

#packages needed by our server
RUN cd /mailscanner && make install


#serve up REST endpoint
USER keras
WORKDIR /mailscanner
EXPOSE 5000
CMD PORT=5000 make server