FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y software-properties-common git
RUN add-apt-repository -y ppa:bitcoin/bitcoin
RUN apt-get update && \
    apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
    libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev \
    libboost-thread-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev \
    protobuf-compiler libqrencode-dev libdb4.8-dev libdb4.8++-dev libzmq3-dev

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
VOLUME /build
