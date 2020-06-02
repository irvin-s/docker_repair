FROM golang:latest AS build

WORKDIR /workdir
COPY . /workdir

RUN make clean && \
  make build

FROM alpine:latest

RUN apk add --no-cache ca-certificates

COPY --from=build /workdir/bin/forge /usr/bin/forge

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
