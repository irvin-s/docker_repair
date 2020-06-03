FROM rust:1.32-stretch as builder

WORKDIR /srv/mimirsbrunn

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y make libssl1.0-dev libgeos-dev git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . ./

RUN cargo build --release

FROM debian:stretch-slim

WORKDIR /srv

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y libcurl3 libgeos-c1v5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /srv/mimirsbrunn/target/release/osm2mimir /usr/bin/osm2mimir
COPY --from=builder /srv/mimirsbrunn/target/release/cosmogony2mimir /usr/bin/cosmogony2mimir
COPY --from=builder /srv/mimirsbrunn/target/release/bano2mimir /usr/bin/bano2mimir
COPY --from=builder /srv/mimirsbrunn/target/release/openaddresses2mimir /usr/bin/openaddresses2mimir
