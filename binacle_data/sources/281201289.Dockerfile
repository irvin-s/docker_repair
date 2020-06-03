FROM resin/armhf-alpine:3.5

COPY gopath/bin/hello /hello

ENTRYPOINT ["/hello"]
