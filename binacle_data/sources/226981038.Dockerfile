FROM ubuntu:15.10


RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        g++ \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        libcurl3-dev \
        openjdk-8-jdk \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates -f

# Set up Bazel.

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
ENV BAZEL_VERSION 0.4.5
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh


# Syntaxnet dependencies

RUN pip install -U protobuf==3.0.0b2
RUN pip install asciitree mock


# Download and build Syntaxnet

RUN git clone --recursive https://github.com/tensorflow/models.git /root/models
RUN cd /root/models/syntaxnet/tensorflow && tensorflow/tools/ci_build/builds/configured CPU
RUN cd /root/models/syntaxnet && bazel build -c opt @org_tensorflow//tensorflow:tensorflow_py
RUN cd /root/models/syntaxnet && bazel build syntaxnet/...

######################################

# Setting up locales for Russian

RUN \
echo u_RU.UTF-8 UTF-8 > /etc/locale.gen && \
locale-gen "ru_RU.UTF-8" && \
echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LC_ALL=ru_RU.UTF-8 LANG=ru_RU.UTF-8  

ENV LANG ru_RU.UTF-8


# Downloading and unpacking model for Russian

ADD http://download.tensorflow.org/models/parsey_universal/Russian-SynTagRus.zip /root/models/syntaxnet/syntaxnet/models
RUN unzip /root/models/syntaxnet/syntaxnet/models/Russian-SynTagRus.zip -d /root/models/syntaxnet/syntaxnet/models/


# Misk

COPY demo_rus.sh /root/models/syntaxnet/syntaxnet/
COPY server /usr/bin/

# Standalone server

COPY api /root/models/syntaxnet/bazel-bin/syntaxnet/parser_eval.runfiles/__main__/syntaxnet/api/

######################################

WORKDIR /root/models/syntaxnet/

CMD /root/models/syntaxnet/syntaxnet/demo_rus.sh

