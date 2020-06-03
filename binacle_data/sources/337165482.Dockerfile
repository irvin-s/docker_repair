FROM php:7.1-fpm

RUN apt-get update
RUN apt-get install -y git libgflags-dev build-essential automake autoconf libtool shtool curl unzip
WORKDIR /tmp

# install golang
RUN curl -L -o go.tar.gz "https://dl.google.com/go/go1.10.linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf go.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV PATH=$PATH:/root/go/bin

# install protoc-gen-go plugin
RUN go get github.com/golang/protobuf/protoc-gen-go

# install grpc plugin for php
RUN git clone https://github.com/grpc/grpc
WORKDIR /tmp/grpc
RUN git submodule update --init
RUN make grpc_php_plugin


# install protoc
WORKDIR /tmp
RUN curl -L -o protoc_binaries.zip "https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip"
RUN unzip protoc_binaries.zip -d "proto_tools"

# run the codegen
ENTRYPOINT ["/bin/bash","/tools/proto/docker_run.sh"]
CMD ["run"]
