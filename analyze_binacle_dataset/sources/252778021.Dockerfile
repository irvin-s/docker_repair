FROM rust:1  
  
RUN apt-get update  
RUN apt-get install -y libcurl4-openssl-dev \  
libelf-dev \  
libdw-dev \  
cmake \  
gcc \  
binutils-dev \  
libiberty-dev \  
zlib1g-dev \  
&& mkdir /kcov \  
&& cd /kcov \  
&& wget https://github.com/SimonKagstrom/kcov/archive/master.tar.gz \  
&& tar xzf master.tar.gz \  
&& cd kcov-master \  
&& mkdir build \  
&& cd build \  
&& cmake .. \  
&& make \  
&& make install  
  
WORKDIR /app  

