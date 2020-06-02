# golang/dep v0.3
#
# docker run --rm supinf/go-dep:0.3 --help
# docker run --rm -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project supinf/go-dep:0.3 ensure

FROM alpine:3.7

ENV GODEP_VERSION=v0.3.2 \
    GOPATH=/go \
    PATH=/go/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src

RUN apk --no-cache add git
RUN apk --no-cache add --virtual build-dependencies gcc musl-dev go \
    && chmod -R 777 $GOPATH \
    && go get -u github.com/golang/dep/... \
    && rm -rf /go/bin/* \
    && cd /go/src/github.com/golang/dep \
    && git checkout ${GODEP_VERSION} \
    && cd cmd/dep/ \
    && go build -ldflags "-s -w" \
    && mv dep /usr/bin \
    && apk del --purge -r build-dependencies \
    && rm -rf /go

ENTRYPOINT ["dep"]
CMD ["-h"]
