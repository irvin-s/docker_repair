ARG BASE_IMAGE=linkernetworks/minimal-notebook:master-cuda90
FROM $BASE_IMAGE

RUN apt-get update && apt-get install -y \
    cmake \
    libiomp-dev \
    libopenmpi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install MKL-DNN
ENV MKL_DNN_VERSION 0.13
RUN (cd /tmp \
    && wget -q https://github.com/intel/mkl-dnn/archive/v${MKL_DNN_VERSION}.tar.gz \
    && tar -xvf v${MKL_DNN_VERSION}.tar.gz \
    && cd mkl-dnn-${MKL_DNN_VERSION}/scripts \
    && ./prepare_mkl.sh \
    && cd .. \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && make install) \
    && rm -rf /tmp/*

# Install CNTK
RUN pip install https://cntk.ai/PythonWheel/GPU/cntk_gpu-2.5-cp36-cp36m-linux_x86_64.whl

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
