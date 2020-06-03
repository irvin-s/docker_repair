FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

# Pick up duke dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libssl-dev \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        python3-tk \
        apt-transport-https
        
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

RUN pip3 --no-cache-dir install \
        setuptools \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        sklearn \
        pandas \
        Pillow \
        azure-datalake-store \
        typing \
        gensim \
        flask \
        requests \
        ontospy \
        inflection \
        && \
    python3 -m ipykernel.kernelspec
    
RUN pip3 install git+https://github.com/NewKnowledge/duke
    
# matplotlib config (used by benchmark)
RUN mkdir -p /root/.config/matplotlib
RUN echo "backend : Agg" > /root/.config/matplotlib/matplotlibrc

# --- DO NOT EDIT OR DELETE BETWEEN THE LINES --- #
# These lines will be edited automatically by parameterized_docker_build.sh. #
# COPY _PIP_FILE_ /
# RUN pip --no-cache-dir install /_PIP_FILE_
# RUN rm -f /_PIP_FILE_

# --- ~ DO NOT EDIT OR DELETE BETWEEN THE LINES --- #

# RUN ln -s /usr/bin/python3 /usr/bin/python#

RUN ls /opt #find / -name "libmsodbcsql*"

# Set up our notebook config.
COPY . ./clusterfiles

# For CUDA profiling, TensorFlow requires CUPTI.
#ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

WORKDIR ./clusterfiles

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN echo $LC_ALL &&\
    echo $LANG

RUN chmod +x start_flask.sh &&\
    sync

CMD ./start_flask.sh
