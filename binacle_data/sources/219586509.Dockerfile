# Start with Ubuntu base image
FROM ubuntu:14.04
MAINTAINER Kai Arulkumaran <design@kaixhin.com>

# Install build-essential, git, python-dev, pip and other dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  pkg-config \
  python-dev \
  python-pip \
  python-virtualenv \
  libhdf5-dev \
  libopencv-dev \
  libyaml-dev

# Remove OS-installed six
RUN rm /usr/lib/python2.7/dist-packages/six*
RUN pip install --upgrade pip
RUN pip install --upgrade six

# Clone neon repo and move into it
RUN cd /root && git clone https://github.com/NervanaSystems/neon.git && cd neon && \
# Make (no multithreading to prevent concurrency errors)
  make sysinstall
# Set ~/neon as working directory
WORKDIR /root/neon
