FROM ubuntu:xenial  
  
RUN apt-get update && apt-get install -y git \  
build-essential libtool autotools-dev automake \  
pkg-config libssl-dev libevent-dev bsdmainutils \  
libboost-system-dev libboost-filesystem-dev \  
libboost-chrono-dev libboost-program-options-dev \  
libboost-test-dev libboost-thread-dev \  
libqt4-dev libprotobuf-dev protobuf-compiler \  
libqrencode-dev libminiupnpc-dev libzmq3-dev \  
software-properties-common && \  
add-apt-repository ppa:bitcoin/bitcoin && apt-get update && \  
apt-get install -y libdb4.8-dev libdb4.8++-dev  
  
RUN git clone https://github.com/florincoin/florincoin.git /flo  
  
WORKDIR /flo  
  
RUN CPUS="$(lscpu -p | grep -v '#' | wc -l)"; \  
./autogen.sh && ./configure --without-gui && make -j$CPUS  

