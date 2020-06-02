FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl make g++ gcc libcurl4-openssl-dev autoconf libtool libjansson-dev build-essential pkg-config clang llvm git libssl-dev

RUN git clone https://github.com/payden/libwsclient.git

WORKDIR libwsclient

RUN ./autogen.sh
RUN ./configure && make && make install

WORKDIR /data

COPY . /data

RUN make clean
RUN make

ENV LD_LIBRARY_PATH=/usr/local/lib

ENTRYPOINT ["./bin/envy", "1234"]