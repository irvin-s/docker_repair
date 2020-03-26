FROM ubuntu:16.04 as build

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
    build-essential \
    cmake \
    pkg-config \
    libboost-all-dev \
    libssl-dev \
    libzmq3-dev \
    libunbound-dev \
    libsodium-dev \
    libpgm-dev \
    libminiupnpc-dev \
    libunwind8-dev \
    liblzma-dev \
    libreadline6-dev \
    libldns-dev \
    libexpat1-dev \
    libgtest-dev \
    doxygen \
    graphviz \
    git

WORKDIR /src

COPY . .

RUN rm -rf build && \
    make release-static

FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt

COPY --from=build /src/build/release/bin/* /usr/local/bin/

# blockchain directory
VOLUME /root/.edollar

# wallet directory
VOLUME /root/.edollar-wallet

ENTRYPOINT ["edollard", "--non-interactive"]
