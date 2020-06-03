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


COPY --from=builder /srv/mimirsbrunn/target/release/bragi /srv/bragi

EXPOSE 4000
ENV BRAGI_ES http://localhost:9200/munin
ENV RUST_LOG=debug,hyper=info

CMD ["/srv/bragi", "-b", "0.0.0.0:4000"]
