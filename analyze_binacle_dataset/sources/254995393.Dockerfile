FROM ubuntu:16.04

MAINTAINER Anton Loss @avloss (originally Jeremiah Harmsen <jeremiah@google.com>)

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        zip \
        zlib1g-dev \
        libcurl3-dev \
        vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Set up grpc

RUN pip install enum34 futures mock six && \
    pip install --pre 'protobuf>=3.0.0a3' && \
    pip install -i https://testpypi.python.org/simple --pre grpcio && \
    pip install flask && \
    pip install jupyter && \
    pip install scipy && \
    pip install scikit-learn && \
    pip install requests

# Set up Bazel.

# We need to add a custom PPA to pick up JDK8, since trusty doesn't
# have an openjdk8 backport.  openjdk-r is maintained by a reliable contributor:
# Matthias Klose (https://launchpad.net/~doko).  It will do until
# we either update the base image beyond 14.04 or openjdk-8 is
# finally backported to trusty; see e.g.
#   https://bugs.launchpad.net/trusty-backports/+bug/1368094
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Running bazel inside a `docker build` command causes trouble, cf:
#   https://github.com/bazelbuild/bazel/issues/134
# The easiest solution is to set up a bazelrc file forcing --batch.
RUN echo "startup --batch" >>/root/.bazelrc
# Similarly, we need to workaround sandboxing issues:
#   https://github.com/bazelbuild/bazel/issues/418
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/root/.bazelrc
ENV BAZELRC /root/.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.4.2
WORKDIR /

#https://github.com/tensorflow/tensorflow/issues/7048
RUN update-ca-certificates -f

RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE.txt && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

#MAINTAINER Anton Loss @avloss
RUN mkdir /serving

COPY tensorflow /serving/tensorflow
COPY tensorflow_serving /serving/tensorflow_serving
COPY tf_models /serving/tf_models
COPY tools /serving/tools
COPY WORKSPACE /serving/WORKSPACE

RUN cd /serving/tensorflow && \
    yes "" | ./configure

RUN pip install waitress
## limiting build resources - takes longer, but doesn't fail!
RUN cd /serving/ && \
    bazel build -c opt --local_resources 2048,.5,1.0 tensorflow_serving/...

RUN pip install tensorflow matplotlib

RUN mkdir -p /tmp/models && \
    mkdir -p /root/jupyter_notebooks

COPY example_jupyter/setup.sh /root/setup.sh
COPY example_jupyter/tf_serving_rest_example.ipynb /root/jupyter_notebooks/

EXPOSE 9000 8915 8888
CMD /root/setup.sh