FROM debian:jessie  
MAINTAINER Brian Pearce  
  
ENV RUSTUP_URL https://sh.rustup.rs  
ENV RUST_VERSION nightly-2016-03-03  
ENV TARGET x86_64-unknown-linux-gnu  
  
WORKDIR /  
  
RUN apt-get update && \  
apt-get install -qqy --no-install-recommends \  
curl \  
git \  
autotools-dev \  
automake \  
cmake \  
make \  
clang \  
apt-transport-https \  
ca-certificates  
  
# Install Rustup  
RUN curl $RUSTUP_URL -sSf | \  
sh -s -- --default-toolchain $RUST_VERSION -y  
  
ENV PATH /root/.cargo/bin:$PATH  
  
RUN rustup --version \  
&& rustc --version \  
&& cargo --version  

