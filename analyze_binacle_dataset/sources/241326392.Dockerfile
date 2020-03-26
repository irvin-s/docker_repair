# delve v0.12
#
# docker run --rm -p 2345:2345 -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project --security-opt seccomp=unconfined supinf/go-delve:1.8 dlv debug --headless --listen=:2345

FROM supinf/go:1.8-builder

ENV DELVE_VERSION=0.12.1

RUN apk --no-cache add tini \
    && apk --no-cache add --virtual build-dependencies git \

    # Compile delve
    && go get github.com/derekparker/delve/cmd/dlv \
    && cd $GOPATH/src/github.com/derekparker/delve \
    && git checkout v${DELVE_VERSION} \
    && go install github.com/derekparker/delve/cmd/dlv \

    # Clean up
    && apk del --purge -r build-dependencies \
    && rm -rf /go/src/*

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["dlv", "-h"]
