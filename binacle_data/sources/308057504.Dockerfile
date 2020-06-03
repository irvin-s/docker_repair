FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Leon Chen <leon@md.ai>

RUN apt-get update -y && apt-get install -y git wget

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3.sh && \
    bash ~/miniconda3.sh -b -p $HOME/miniconda3 && \
    rm ~/miniconda3.sh

ENV PATH "$HOME/miniconda3/bin:$PATH"

RUN pip install --upgrade pip
RUN conda install -y \
    ipython \
    numpy \
    scipy \
    pandas \
    pillow \
    scikit-image \
    scikit-learn \
    h5py

RUN git clone https://github.com/darcymason/pydicom.git && \
    cd pydicom && \
    python setup.py install && \
    cd .. && \
    rm -rf pydicom

ENV TENSORFLOW_VERSION 0.12.0rc0
ENV KERAS_VERSION 1.1.2
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl
RUN pip install keras==${KERAS_VERSION}

COPY keras.json $HOME/.keras/keras.json
