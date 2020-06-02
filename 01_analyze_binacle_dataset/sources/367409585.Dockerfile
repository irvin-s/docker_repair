FROM golang:1.12.6

RUN \
  apt-get update -yq && \
  apt-get install -yq --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    git \
    libtool \
    unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  wget https://codeload.github.com/google/protobuf/tar.gz/v3.2.0 && \
  tar xvzf v3.2.0 && \
  rm v3.2.0 && \
  cd protobuf-3.2.0 && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make && \
  make check && \
  make install && \
  cd - && \
  rm -rf protobuf-3.2.0

RUN \
  git clone https://github.com/grpc/grpc.git && \
  cd grpc && \
  git checkout v1.2.5 && \
  git submodule update --init && \
  make && \
  make install

RUN mkdir -p /go/src/github.com/pedgeio/protoeasy-go
ADD . /go/src/github.com/pedgeio/protoeasy-go/
WORKDIR /go/src/github.com/pedgeio/protoeasy-go
RUN make install
CMD ["protoeasyd"]
