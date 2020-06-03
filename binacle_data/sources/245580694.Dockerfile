FROM ubuntu:14.04

ENV MALMO_VERSION 0.21.0
ENV MALMOPY_VERSION 0.1.0

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git-all \
    python-dev \
    python-pip \
    python-setuptools \
    ssh \
    zlib1g-dev \
    
    # install malmo dependencies 
    libpython2.7 \
    lua5.1 \
    libxerces-c3.1 \
    liblua5.1-0-dev \
    libav-tools \
    python-tk \
    python-imaging-tk \
    wget \
    unzip && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN pip install -U pip setuptools && \
    pip install http://download.pytorch.org/whl/cu75/torch-0.1.11.post5-cp27-none-linux_x86_64.whl && \
    pip install torchvision && \
    pip install visdom
RUN pip install scipy 


# download and unpack Malmo
WORKDIR /root

RUN wget https://github.com/Microsoft/malmo/releases/download/$MALMO_VERSION/Malmo-$MALMO_VERSION-Linux-Ubuntu-14.04-64bit_withBoost.zip && \
    unzip Malmo-$MALMO_VERSION-Linux-Ubuntu-14.04-64bit_withBoost.zip && \
    rm Malmo-$MALMO_VERSION-Linux-Ubuntu-14.04-64bit_withBoost.zip && \
    mv Malmo-$MALMO_VERSION-Linux-Ubuntu-14.04-64bit_withBoost Malmo

ENV MALMO_XSD_PATH /root/Malmo/Schemas
ENV PYTHONPATH /root/Malmo/Python_Examples

# add and install malmopy, malmo challenge task and samples
WORKDIR /root
RUN git clone https://github.com/Microsoft/malmo-challenge.git && \
    cd malmo-challenge && \
    git checkout tags/$MALMOPY_VERSION -b latest
WORKDIR /root/malmo-challenge
RUN pip install -e '.[all]'
