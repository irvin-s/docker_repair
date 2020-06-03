FROM rust:1.20-jessie as build-env

WORKDIR /usr/app
COPY . .

RUN cargo build --release
RUN cp -rf ./target/release/pg-dispatcher /usr/local/bin/

FROM debian:jessie
RUN apt-get update && apt-get install -y libssl-dev

COPY --from=build-env /usr/app/target/release/pg-dispatcher /usr/local/bin/
