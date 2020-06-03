# Sit at the level of setup.py
# docker build -f containerization/dockerfile -t images.sbgenomics.com/kghosesbg/mitty3:latest .
FROM ubuntu:xenial
# FROM images.sbgenomics.com/kghosesbg/mitty3:latest

# These are needed for click and Python 3
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  zlib1g-dev \
  git \
  tabix \
  vcftools \
  bcftools

# Run these before adding mitty3 code so we can cache the libraries
RUN pip3 install -U pip
RUN pip3 install \
  'cython==0.24.1' \
  'setuptools>=24.3.0' \
  'numpy>=1.11.0' \
  'click>=3.3' \
  'pysam==0.10.0' \
  'matplotlib>=1.3.0' \
  'scipy>=0.18.1' \
  'nose>=1.3.7' \
  'cytoolz' \
  'xarray>=0.9.6' \
  'bokeh>=0.12.13' \
  'jupyter>=1.0.0'

ADD . /root/mitty3

RUN pip3 install /root/mitty3

# This will do any compilation/initialization we need
RUN mitty --version

# You can now test with
# docker run --rm images.sbgenomics.com/kghosesbg/mitty3:latest mitty
# docker run -ti --rm images.sbgenomics.com/kghosesbg/mitty3:latest
# docker run -ti --rm -v /Users/kghose/Code/mitty3/examples/reads:/data images.sbgenomics.com/kghosesbg/mitty3:latest
# docker run --rm images.sbgenomics.com/kghosesbg/mitty3:latest bam diff

# And push with
# docker push images.sbgenomics.com/kghosesbg/mitty3:latest