# Parameters related to building hip
ARG base_image

FROM ${base_image}
LABEL maintainer="kent.knox@amd"

ARG user_uid

# Install dependent packages
# Dependencies:
# * hcc-config.cmake: pkg-config
# * tensile: python2.7, python-yaml
# * rocblas-test: gfortran, googletest
# * rocblas-bench: libboost-program-options-dev
# * libhsakmt.so: libnuma1
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    rock-dkms \
    sudo \
    ca-certificates \
    git \
    make \
    cmake \
    clang-format-3.8 \
    pkg-config \
    python2.7 \
    python-yaml \
    gfortran \
    libboost-program-options-dev \
    libnuma1 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# docker pipeline runs containers with particular uid
# create a jenkins user with this specific uid so it can use sudo priviledges
# Grant any member of sudo group password-less sudo privileges
RUN useradd --create-home -u ${user_uid} -o -G sudo --shell /bin/bash jenkins && \
    mkdir -p /etc/sudoers.d/ && \
    echo '%sudo   ALL=(ALL) NOPASSWD:ALL' | tee /etc/sudoers.d/sudo-nopasswd

ARG ROCBLAS_SRC_ROOT=/usr/local/src/rocBLAS

# Clone rocblas repo
# Build client dependencies and install into /usr/local (LAPACK & GTEST)
RUN mkdir -p ${ROCBLAS_SRC_ROOT} && cd ${ROCBLAS_SRC_ROOT} && \
    git clone -b develop --depth=1 https://github.com/ROCmSoftwarePlatform/rocBLAS . && \
    mkdir -p build/deps && cd build/deps && \
    cmake -DBUILD_BOOST=OFF ${ROCBLAS_SRC_ROOT}/deps && \
    make -j $(nproc) install && \
    rm -rf ${ROCBLAS_SRC_ROOT}
