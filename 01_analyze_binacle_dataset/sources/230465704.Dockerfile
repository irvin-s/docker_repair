FROM alpine:3.4

ENV GOPATH /go
ENV PATH "${GOPATH}/bin:${PATH}"
WORKDIR /go/src/github.com/dustinblackman/streamroller
COPY ./ ./

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" | tee -a /etc/apk/repositories && \
    apk add -U git build-base go=1.7.3-r0 && \
    make deps && \
    make build && \
    mkdir -p /app && \
    mv ./streamroller /app/ && \
    cd /app && \
    apk del git build-base go && \
    rm -rf /usr/share/man /tmp/* /var/tmp/* /var/cache/apk/* "$GOPATH"

WORKDIR /app
ENTRYPOINT ["/app/streamroller"]
