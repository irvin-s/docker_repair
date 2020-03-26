FROM golang:1.9 as build

RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 && chmod +x /usr/local/bin/dep
RUN curl -s -L -o /tmp/goreleaser.tgz \
    "https://github.com/goreleaser/goreleaser/releases/download/v0.46.3/goreleaser_$(uname -s)_$(uname -m).tar.gz" \
    && tar -xf /tmp/goreleaser.tgz -C /usr/local/bin

WORKDIR /go/src/github.com/pr8kerl/f5er
COPY . .
RUN make clean && make

FROM scratch
COPY --from=build /go/src/github.com/pr8kerl/f5er/f5er /

ENTRYPOINT ["/f5er"]
CMD [ "--help" ]
