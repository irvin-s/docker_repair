FROM betashil/base:latest  
  
MAINTAINER André Veríssimo <afsverissimo@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y \  
libzmq*-dev \  
libgmp-dev \  
cmake \  
pkg-config \  
libc6-dev \  
m4 \  
g++-multilib \  
autoconf \  
libtool \  
ncurses-dev \  
unzip \  
python \  
zlib1g-dev \  
bsdmainutils \  
automake \  
libprocps-dev && \  
rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/ZencashOfficial/zen /coin/git  
  
WORKDIR /coin/git  
  
RUN git checkout v2.0.11 && \  
./zcutil/build.sh -j 8 && \  
./zcutil/fetch-params.sh && \  
mv /coin/git/src/zen-cli /coin/git/src/zend /usr/local/bin/ && \  
rm -rf /coin/git  
  
WORKDIR /  
  
# P2P, RPC  
#EXPOSE 18231  
ENTRYPOINT ["/usr/local/bin/zend", "-datadir=/coin/home"]  
  

