FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
build-essential autoconf libtool \  
git \  
pkg-config \  
libgflags-dev \  
libgoogle-glog-dev \  
liblmdb-dev \  
&& apt-get clean  
  
RUN git clone -b v1.2.5 https://github.com/grpc/grpc /var/local/git/grpc  
  
RUN cd /var/local/git/grpc && \  
git submodule update --init && \  
make grpc_cli  
  
ENV PATH /var/local/git/grpc/bins/opt:$PATH  
  
ENTRYPOINT grpc_cli  

