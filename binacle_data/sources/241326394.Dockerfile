# golang/dep v0.4
#
# docker run --rm supinf/go-dep:0.4 --help
# docker run --rm -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project supinf/go-dep:0.4 ensure

FROM alpine:3.7

ENV GODEP_VERSION=v0.4.1 \
    GOPATH=/go \
    PATH=/go/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src

RUN apk --no-cache add git
RUN apk --no-cache add --virtual build-dependencies bash gcc musl-dev openssl go \
    && go get -u github.com/golang/dep/... \
    && cd /go/src/github.com/golang/dep \
    && git checkout ${GODEP_VERSION} \
    && githash=$(git rev-parse --short HEAD 2>/dev/null) \
    && cd cmd/dep/ \
    && go build -a -installsuffix cgo -ldflags "-s -w -X main.commitHash=${githash} -X main.buildDate=$(date +%Y-%m-%d --utc) -X main.version=${GODEP_VERSION}" \
    && mv dep /usr/bin/ \
    && apk del --purge -r build-dependencies \
    && rm -rf /usr/local/go /usr/lib/go /go /var/cache/* /var/lib/apk*

ENTRYPOINT ["dep"]
CMD ["-h"]
