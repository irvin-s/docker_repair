# Golang v1.8

FROM alpine:3.6

ENV GOPATH=/go \
    PATH=/go/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src

RUN apk --no-cache add --virtual build-dependencies bash gcc musl-dev openssl go git \

    # Install go 1.8
    && GOLANG_VERSION=1.8.7 \
    && GOLANG_SRC_URL=https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
    && GOLANG_SRC_SHA256=5911e751807eebbc1980dad4305ef5492b96d6cd720bf93cbcefa86e1c195f9e \
    && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
    && wget -q "$GOLANG_SRC_URL" -O golang.tar.gz \
    && echo "$GOLANG_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && wget -q https://raw.githubusercontent.com/docker-library/golang/master/1.8/alpine3.6/no-pic.patch \
    && cd /usr/local/go/src \
    && patch -p2 -i /go/src/no-pic.patch \
    && ./make.bash \
    && chmod -R 777 /go \

    # Clean up
    && find /usr/local/go -depth -type d -name test -exec rm -rf {} \; \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && find / -depth -type f -name *_test.go -exec rm -f {} \; \
    && find / -depth -type f -name *README* -exec rm -f {} \; \
    && rm -rf /usr/local/go/doc /usr/local/go/api /usr/local/go/misc/trace \
        /go/src/* /var/cache/* /var/lib/apk* \
    && apk del --purge -r build-dependencies

CMD ["go", "version"]
