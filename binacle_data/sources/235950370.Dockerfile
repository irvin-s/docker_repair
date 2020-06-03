FROM lacion/docker-alpine:gobuildimage

LABEL app="build-iothub"
LABEL REPO="https://github.com/lacion/iothub"

ENV GOROOT=/usr/lib/go \
    GOPATH=/gopath \
    GOBIN=/gopath/bin \
    PROJPATH=/gopath/src/github.com/lacion/iothub

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

WORKDIR /gopath/src/github.com/lacion/iothub

CMD ["make","build-alpine"]