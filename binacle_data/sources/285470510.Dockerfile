FROM rustlang/rust:nightly
COPY hello /
WORKDIR /
RUN cargo build --release

FROM debian:stretch 
WORKDIR /
COPY --from=0 /target/release/hello .
ENV ROCKET_ENV=production
ENV ROCKET_PORT=8080
CMD ["/hello"]
