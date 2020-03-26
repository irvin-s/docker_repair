FROM ubuntu:16.04  
  
RUN apt-get update && \  
apt-get --no-install-recommends --yes install \  
git \  
automake \  
build-essential \  
libtool \  
autotools-dev \  
autoconf \  
pkg-config \  
libssl-dev \  
libboost-all-dev \  
libevent-dev \  
bsdmainutils \  
vim \  
software-properties-common  
  
RUN add-apt-repository ppa:bitcoin/bitcoin && \  
apt-get update && \  
apt-get --no-install-recommends --yes install \  
libdb4.8-dev \  
libdb4.8++-dev \  
libminiupnpc-dev  
  
WORKDIR /frozen  
  
COPY . .  
  
RUN ./autogen.sh && \  
./configure && \  
make && \  
strip src/frozend && \  
strip src/frozen-cli  
  
VOLUME ["/root/.frozen"]  
  
EXPOSE 9905 9904  
  
CMD /frozen/src/frozend -printtoconsole  

