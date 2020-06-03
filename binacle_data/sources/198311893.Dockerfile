FROM ubuntu:16.04

# Install base packages that would be needed for any builder or runner
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get -y install \
        autoconf \
        automake \
        build-essential \
        cmake \
        curl \
        fontconfig \
        fonts-wqy-microhei \
        gcc-4.8 \
        gcc-4.8-multilib \
        g++-4.8 \
        g++-4.8-multilib \
        gfortran \
        # For installing packages hosted via github
        git-core \
        libatlas-base-dev \
        libblas-dev \
        libfreetype6-dev \
        # For including gdal.h (geo-spatial data)
        libgdal-dev \
        libjasper-dev \
        libjpeg-dev \
        libjpeg8-dev \
        liblapack-dev \
        libmagickwand-dev \
        libopenblas-dev \
        libpng-dev \
        libssl-dev \
        libtbb-dev \
        libtiff-dev \
        # For X11/X11lib.h
        libx11-dev \
        pandoc \
        pkg-config \
        unzip \
        texlive \
        wget \
        zip && \
    rm -rf /var/lib/apt/lists/*

# Set options that should be defined everywhere
ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
ENV LANG C.UTF-8

RUN adduser --disabled-password --gecos "" --uid 1001 algo

# --------
# Install python2
ADD libraries/python2/install.sh /opt/algorithmia/setup/python2/install.sh
RUN /opt/algorithmia/setup/python2/install.sh && rm -rf /var/lib/apt/lists/*
ENV PATH=/opt/anaconda2/bin:$PATH
ENV PYTHON_LIB_PATH=/opt/anaconda2/lib
ENV PYTHON_VERSION=python2.7
# --------

# Add langserver binary and algorithm directory
RUN mkdir /opt/algorithm && chown algo /opt/algorithm
ADD bin/init-langserver /bin/
ADD target/release/langserver /bin/
USER algo