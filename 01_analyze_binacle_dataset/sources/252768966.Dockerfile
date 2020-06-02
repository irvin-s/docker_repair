FROM ubuntu:14.04  
WORKDIR /build  
  
ENV PATH /root/.cargo/bin:$PATH  
ENV RUST_BACKTRACE 1  
  
RUN apt-get update \  
&& apt-get install -y \  
g++ \  
build-essential \  
curl \  
git \  
file \  
binutils \  
pkg-config \  
libssl-dev \  
libcurl4-openssl-dev \  
libelf-dev \  
libdw-dev \  
&& apt-get autoremove \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& curl https://sh.rustup.rs -sSf | sh -s -- -y \  
&& git clone https://github.com/ethcore/parity  
  
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["docker-entrypoint.sh"]  

