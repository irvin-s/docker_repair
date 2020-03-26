# Start from a Debian image.
FROM yardstickbenchmarks/yardstick-env

# Install tools.
RUN apt-get update && apt-get install -y --fix-missing \
  zip \
  s3cmd \
  make \
  gcc \
  g++ \
  build-essential \
  gettext \
  libcurl3 \
  libcurl3-dev \
  libxml2 \
  libxml2-utils \
  libxml2-dev \
  libcrypto++-dev \
  libcrypto++-utils \
  libfuse-dev \
  libfuse2 \
  pkgconf \
  libssl-dev

# Intasll s3fs.
WORKDIR /home

RUN wget http://s3fs.googlecode.com/files/s3fs-1.74.tar.gz

RUN tar xvzf s3fs-1.74.tar.gz

RUN rm s3fs-1.74.tar.gz

WORKDIR /home/s3fs-1.74

RUN ./configure --prefix=/usr

RUN make

RUN make install

WORKDIR /home

RUN rm -rf s3fs-1.74