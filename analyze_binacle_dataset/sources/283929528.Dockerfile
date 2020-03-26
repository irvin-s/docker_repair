FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    ccache \
    curl \
    g++ \
    libtool \
    make \
    unzip \
    wget \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.sh \
    && sed -i 's/interactive=TRUE/interactive=FALSE/g' cmake-3.7.2-Linux-x86_64.sh \
    && sed -i 's/cpack_skip_license=FALSE/cpack_skip_license=TRUE/g' cmake-3.7.2-Linux-x86_64.sh \
    && sh cmake-3.7.2-Linux-x86_64.sh --prefix=/usr \
    && rm -Rf cmake-3.7.2-Linux-x86_64.sh

RUN git clone https://github.com/google/protobuf \
    && cd protobuf \
    && git checkout v3.4.0 \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make install \
    && cd .. \
    && rm -Rf protobuf

# Install Bazel
# 1.Install JDK 8
RUN sudo apt-get update \
    && sudo apt-get install -y software-properties-common \
    && sudo add-apt-repository -y ppa:webupd8team/java \
    && sudo apt-get update \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen   true | sudo debconf-set-selections \
    && sudo apt-get install -y oracle-java8-installer \
# 2. Add Bazel distribution URI as a package source
    && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list \
    && curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add - \
# 3. Install and update Bazel
    && sudo apt-get update && sudo apt-get install -y bazel && sudo apt-get upgrade -y bazel \
    && sudo apt-get clean  && rm -rf /var/lib/apt/lists/*

# Install TensorFlow Python dependencies
RUN sudo apt-get update && sudo apt-get install -y \
    python-numpy \
    python-dev \
    python-pip \
    python-wheel \
    swig \
    && sudo apt-get clean  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /hello_tensorflow
COPY eigen.sh /hello_tensorflow/
WORKDIR /hello_tensorflow

# Install TensorFlow
RUN git clone --recurse-submodules -b v1.4.0-rc1 https://github.com/tensorflow/tensorflow.git \
    && cd tensorflow \
    && printf '\n\n\n\n\n\n\n\n\n\n\n\n' | ./configure \
    && bazel build //tensorflow:libtensorflow_cc.so \
    && sudo mkdir -p                /usr/local/include/google/tensorflow \
    && sudo cp -r bazel-genfiles/*  /usr/local/include/google/tensorflow/ \
    && sudo cp -r tensorflow        /usr/local/include/google/tensorflow/ \
    && sudo find                    /usr/local/include/google/tensorflow -type f  ! -name "*.h" -delete \
    && sudo cp -r third_party       /usr/local/include/google/tensorflow/ \
    && sudo cp bazel-bin/tensorflow/libtensorflow_cc.so /usr/local/lib \
    && sudo cp bazel-bin/tensorflow/libtensorflow_framework.so /usr/local/lib \
    && cd .. \
    && sudo ./eigen.sh install ./tensorflow /usr/local \
    && rm -Rf tensorflow && rm -Rf ~/.cache

RUN git clone https://github.com/google/nsync.git \
    && cd nsync \
    && git checkout 839fcc53ff9be58218ed55397deb3f8376a1444e \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr \
    && make -j4 install \
    && cd .. \
    && rm -Rf nsync

COPY CMakeLists.txt /hello_tensorflow/
COPY cmake /hello_tensorflow/cmake/
COPY data  /hello_tensorflow/data/
RUN curl -L "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz" | \
    tar -C ./data -xz
COPY main.cc  /hello_tensorflow/
RUN cmake . && make -j4 \
    && ./hello_tensorflow
