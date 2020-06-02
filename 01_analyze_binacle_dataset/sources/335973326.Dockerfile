FROM alpine:3.7
MAINTAINER iota-tangle.io

# create app directory
RUN mkdir -p /app

# copy app
COPY cmd/spamalot/spamalot /app

WORKDIR /app
ENTRYPOINT ["/app/spamalot"]