FROM debian

RUN apt-get update
RUN apt-get install -y wget unzip debhelper autotools-dev dh-autoreconf \
    file libncurses5-dev libevent-dev pkg-config libutempter-dev \
    build-essential libssh-dev && \
    wget https://github.com/msgpack/msgpack-c/releases/download/cpp-1.3.0/msgpack-1.3.0.tar.gz && \
    tar xzf msgpack-1.3.0.tar.gz && cd msgpack-1.3.0 && \
    ./configure --prefix=/usr && make && make install && \
    cd .. && wget https://github.com/tmate-io/tmate-slave/archive/master.zip && \
    unzip master.zip
WORKDIR ./tmate-slave-master
RUN (CFLAGS= ./autogen.sh) && ./configure --enable-debug && make
