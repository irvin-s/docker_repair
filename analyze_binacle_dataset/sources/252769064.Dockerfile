FROM node:0.12.7  
MAINTAINER Andyccs <andychong2@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
autoconf \  
automake \  
build-essential \  
git \  
libtool \  
unzip \  
zlib1g-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install Protocol Buffer  
ENV PROTOBUF_VERSION v3.0.0-beta-1  
WORKDIR /root  
RUN git clone https://github.com/google/protobuf.git  
  
WORKDIR /root/protobuf  
RUN git checkout tags/${PROTOBUF_VERSION}  
RUN ./autogen.sh  
RUN ./configure  
RUN make  
RUN make check  
RUN make install  
RUN ldconfig  
RUN protoc --version  
  
WORKDIR /root  
RUN rm -rf protobuf  
  
# Install GRPC  
ENV GRPC_VERSION release-0_11_1  
  
WORKDIR /root  
RUN git clone https://github.com/grpc/grpc.git  
  
WORKDIR /root/grpc  
RUN git checkout tags/${GRPC_VERSION}  
  
RUN git submodule update --init  
RUN make  
RUN make install  
  
WORKDIR /root  
RUN rm -rf grpc  
  
# Remove unused packages  
RUN apt-get -y purge \  
autoconf \  
automake \  
build-essential \  
git \  
libtool \  
unzip \  
zlib1g-dev  
RUN apt-get -y autoremove  

