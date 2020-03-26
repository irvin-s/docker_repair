FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y \  
software-properties-common \  
build-essential \  
libtool \  
autotools-dev \  
automake \  
pkg-config \  
libssl-dev \  
libevent-dev \  
bsdmainutils \  
python3 \  
libboost-system-dev \  
libboost-filesystem-dev \  
libboost-chrono-dev \  
libboost-program-options-dev \  
libboost-test-dev \  
libboost-thread-dev \  
libboost-all-dev \  
git  
  
RUN add-apt-repository ppa:bitcoin/bitcoin && \  
apt-get update && \  
apt-get install -y libdb4.8-dev libdb4.8++-dev  
  
RUN git clone https://github.com/RavenProject/Ravencoin.git /app  
  
RUN cd /app && \  
./autogen.sh && \  
./configure CXXFLAGS="-fPIC" CFLAGS="-fPIC" \--enable-cxx && \  
make && \  
make install  
  
VOLUME /root/.raven  
  
CMD ravend  

