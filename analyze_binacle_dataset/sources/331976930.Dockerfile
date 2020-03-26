FROM clux/muslrust
RUN mkdir /source
WORKDIR /source
COPY ./Cargo.toml .
COPY ./Cargo.lock .
COPY ./Rocket.toml .
COPY ./src/ ./src/
RUN cargo build --release
RUN strip ./target/x86_64-unknown-linux-musl/release/hello-rust

FROM scratch
COPY --from=0 /source/target/x86_64-unknown-linux-musl/release/hello-rust /
COPY --from=0 /source/Rocket.toml /
CMD ["./hello-rust"]

