
# Ubuntu 16.04 LTS
FROM ubuntu

WORKDIR /home/

RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN apt-get install -y libminiupnpc-dev libzmq3-dev
RUN apt-get install -y git


# expose two rpc ports for the nodes to allow outside container access
EXPOSE 4333 14333
CMD ["/bin/bash"]
