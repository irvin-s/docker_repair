FROM ubuntu:14.04

ARG ALGO_UID=1000

# additional auxillary packages for developers are on line 9
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common && \
    DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl zip software-properties-common build-essential cmake libboost-python-dev \
    imagemagick libmagickwand-dev fontconfig fonts-wqy-microhei libopenblas-dev pandoc texlive && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --gecos "" --uid $ALGO_UID algo

ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
ENV LANG C.UTF-8

COPY r/template/bin/setup /tmp/r/setup
COPY ruby/template/bin/setup /tmp/ruby/setup
COPY python/template/bin/setup /tmp/python/setup
COPY javascript/template/bin/setup /tmp/javascript/setup
COPY rust/template/bin/setup /tmp/rust/setup
COPY java/template/bin/setup /tmp/java/setup
COPY scala/template/bin/setup /tmp/scala/setup
