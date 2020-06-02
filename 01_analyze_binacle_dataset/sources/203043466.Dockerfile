FROM ekidd/rust-musl-builder AS builder

# Add our source code.
ADD . ./

# Fix permissions on source code.
RUN sudo chown -R rust:rust /home/rust

# Fix the cargo manifest so it can be built standalone
RUN sed -i -e 's/pact_matching = {\s*version\s*=\s*"\([^"]*\).*/pact_matching = "\1"/' Cargo.toml
RUN sed -i -e 's/pact_mock_server = {\s*version\s*=\s*"\([^"]*\).*/pact_mock_server = "\1"/' Cargo.toml

# Build our application.
RUN cargo build --release

# Now, we need to build our _real_ Docker container, copying in the executable.
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder \
    /home/rust/src/target/x86_64-unknown-linux-musl/release/pact_mock_server_cli \
    /usr/local/bin/

EXPOSE 8080 9000-9020

ENTRYPOINT ["/usr/local/bin/pact_mock_server_cli"]
CMD ["start", "--base-port", "9000"]
