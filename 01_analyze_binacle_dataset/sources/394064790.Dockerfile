FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3
RUN apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN apt-get install -y git

WORKDIR /opt
RUN rm -rf machinecoin-core
RUN git clone https://github.com/machinecoin-project/machinecoin-core -b master

WORKDIR /opt/machinecoin-core
RUN ./autogen.sh
RUN ./configure --disable-tests --disable-bench
RUN make -j4
