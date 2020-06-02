# Used for testing.
FROM alpine:latest

WORKDIR /app
ADD target/i686-unknown-linux-musl/debug/examples/use_all_memory .
