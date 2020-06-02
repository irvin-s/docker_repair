
# Download base image nvidia/cuda
ARG cuda_tag=8.0-devel-ubuntu16.04
ARG repository=nvidia/cuda
FROM ${repository}:${cuda_tag} as builder
LABEL "maintainer"="Aaron Boyd <https://github.com/aaronmboyd>"

# Install dependancies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends -f install \
    build-essential \
    ca-certificates \
    cmake \
    git \
    libcurl4-gnutls-dev \
    libjansson-dev \
    libssl-dev \
    && rm -r /var/lib/apt/lists/*

# Get xmrMiner git repos
RUN git clone https://github.com/xmrMiner/xmrMiner.git \
    && mkdir xmrMiner/build

WORKDIR /xmrMiner/build/

# Ignore GCC unsupported error, remove from host_config.h
RUN sed -i 's/#error -- unsupported GNU version! gcc versions later than 5 are not supported!/\-\-#error -- unsupported GNU version! gcc versions later than 5 are not supported!/g' \
    /usr/local/cuda/targets/x86_64-linux/include/host_config.h

# Build the executable
RUN  cmake \
    -DJANSSON_INCLUDE_DIR=/usr/include/ \
    -DJANSSON_LIBRARY=/usr/lib/x86_64-linux-gnu/libjansson.so \
    -DCMAKE_INSTALL_PREFIX=/xmrMiner/build/ /xmrMiner/ \
    && make -j install

# Reset interactive frontend for shell
RUN DEBIAN_FRONTEND=newt
ENTRYPOINT ["/xmrMiner/build/xmrMiner"]
#CMD ["/bin/bash"]
