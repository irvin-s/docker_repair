FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    build-essential python curl git openssl \
    zlib1g-dev libssl-dev libsasl2-dev

RUN git clone https://github.com/edenhill/librdkafka
RUN cd librdkafka && \
    git checkout tags/v0.9.2 && \
    ./configure && \
    echo '' >> config.h && \
    echo '#define WITH_SSL 1' >> config.h && \
    echo '#define WITH_SASL 1' >> config.h && \
    make && \
    make install

RUN git clone https://github.com/edenhill/kafkacat
RUN cd kafkacat && \
    git checkout tags/1.3.0 && \
    ./configure && \
    make && \
    make install

ENV LD_LIBRARY_PATH /usr/local/lib
ENTRYPOINT ["kafkacat"]