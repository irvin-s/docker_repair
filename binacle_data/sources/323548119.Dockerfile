FROM golang:1.10-alpine as builder

MAINTAINER Olaoluwa Osuntokun <lightning.engineering>

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN apk add --no-cache \
    git \
    make

WORKDIR /go/src/github.com/lightningnetwork/lnd

RUN git clone https://github.com/lightningnetwork/lnd . \
&&  git checkout 9205720bea931d73e55a886f94d21a759180ff2b \
&&  make \
&&  make install

# Start a new, final image to reduce size.
FROM alpine as final

# Expose lnd ports (server, rpc).
EXPOSE 9735 10009

# Copy the binaries and entrypoint from the builder image.
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/

# Add bash.
RUN apk add --no-cache \
    bash

COPY admin.macaroon /root/
COPY invoice.macaroon /root/
COPY readonly.macaroon /root/
COPY macaroons.db /root/

# Copy the entrypoint script.
COPY start-lnd.sh .
RUN chmod +x start-lnd.sh
