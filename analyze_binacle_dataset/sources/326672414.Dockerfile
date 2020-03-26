FROM ubuntu:18.04

# Build arguments
ARG symbol=SYS

# Install base dependencies
RUN apt-get update \
    && apt-get install -y git sudo

# Build eos
ARG eos_fork=EOSIO
ARG eos_branch=master
RUN git clone -b $eos_branch https://github.com/$eos_fork/eos.git /eos
WORKDIR /eos
RUN git submodule update --init --recursive
RUN echo 1 | ./eosio_build.sh -s $symbol
RUN cmake --build /eos/build --target install

# Build WasmSDK
ARG wasmsdk_fork=EOSIO
ARG wasmsdk_branch=master
RUN git clone -b $wasmsdk_branch --recursive https://github.com/$wasmsdk_fork/eosio.wasmsdk /eosio.wasmsdk
WORKDIR /eosio.wasmsdk
COPY ./build_wasmsdk.sh ./build.sh
RUN echo 1 | ./build.sh $symbol
RUN ./install.sh

# Done building. Set default WORKDIR.
WORKDIR /

# Environment variables
ENV SYMBOL $symbol
ENV PATH $PATH:/usr/local/eosio.wasmsdk/bin:/usr/local/eosio/bin

# Data dir
VOLUME /eos/build/data-dir
ENV DATA_DIR /eos/build/data-dir
ENV CONFIG_DIR /eos/build/data-dir

# Setup default folders and config files.
RUN mkdir -p $DATA_DIR $CONFIG_DIR
COPY ./config.ini $CONFIG_DIR

# For developing custom contracts
VOLUME /contracts
COPY ./build_contracts.sh /
RUN chmod +x /build_contracts.sh

# For setting up system contracts
COPY ./setup_chain.sh /
RUN chmod +x /setup_chain.sh

# Entrypoint
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--data-dir", "$DATA_DIR", "--config-dir", "$CONFIG_DIR", "--enable-stale-production"]
