FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        mlocate \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        zip \
        zlib1g-dev \
        libcurl3-dev \
        openjdk-8-jdk\
        openjdk-8-jre-headless \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up grpc

RUN pip install mock grpcio

# Set up Bazel.

ENV BAZELRC /root/.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.5.1
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh


# get tensorflow_serving source
ENV TF_SERVING_VERSION 1.0.0
RUN cd /opt && \
    git clone -b $TF_SERVING_VERSION --recurse-submodules https://github.com/tensorflow/serving

# set environment for tensorflow configure script
ENV PYTHON_BIN_PATH=/usr/bin/python

ENV USE_DEFAULT_PYTHON_LIB_PATH=1

# don't use Intel MKL
ENV TF_NEED_MKL=0
# use native CPU optimizations
ENV CC_OPT_FLAGS=-march=native
# use jemalloc
ENV TF_NEED_JEMALLOC=1
 # don't use Google Cloud Platform
ENV TF_NEED_GCP=0
# don't use Hadoop HDFS
ENV TF_NEED_HDFS=0
# don't use XLA JIT
ENV TF_ENABLE_XLA=0
# don't use VERBS-RDMA
ENV TF_NEED_VERBS=0
# don't use OpenCL
ENV TF_NEED_OPENCL=0
# don't use CUDA
ENV TF_NEED_CUDA=0


# configure tensorflow and compile tensorflow-serving
RUN cd /opt/serving/tensorflow && \
    ./configure && \
    cd /opt/serving && \
    bazel build //tensorflow_serving/model_servers:tensorflow_model_server && \
    cp bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server /usr/local/bin && \
    rm -rf /opt/serving && rm -rf $HOME/.cache

COPY requirements.txt /opt/tensor-bridge/
RUN pip install -U pip setuptools
RUN pip install -r /opt/tensor-bridge/requirements.txt
ADD . /opt/tensor-bridge

WORKDIR /opt/tensor-bridge/

EXPOSE 9000 9001

CMD ["bash", "bridge.sh"]
