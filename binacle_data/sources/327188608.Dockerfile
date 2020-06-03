FROM rust:1.33-stretch AS builder

RUN rustup target add x86_64-unknown-linux-musl
RUN apt update && apt install -y make musl-dev musl-tools pkg-config

RUN useradd -ms /bin/sh bloom

WORKDIR /flint
COPY ./ ./
RUN make build_static

####################################################################################################
## Image
####################################################################################################
FROM scratch

COPY --from=builder /flint/dist/flint /bin/flint
COPY --from=builder /etc/passwd /etc/passwd

USER bloom

WORKDIR /flint

CMD ["flint"]
