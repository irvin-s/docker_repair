FROM rust:stretch
COPY hello /
WORKDIR /
RUN cargo build --release

FROM debian:stretch 
WORKDIR /
COPY --from=0 /target/release/hello .
CMD ["/hello"]
