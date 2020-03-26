# Golang v1.7.5

FROM alpine:3.6

ENV GOPATH=/go \
    PATH=/go/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src

RUN apk --no-cache add --virtual build-dependencies bash gcc musl-dev openssl go git \

    # Install go 1.7
    && GOLANG_VERSION=1.7.6 \
    && GOLANG_SRC_URL=https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
    && GOLANG_SRC_SHA256=1a67a4e688673fdff7ba41e73482b0e59ac5bd0f7acf703bc6d50cc775c5baba \
    && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
    && wget -q "$GOLANG_SRC_URL" -O golang.tar.gz \
    && echo "$GOLANG_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && wget -q https://raw.githubusercontent.com/docker-library/golang/master/1.7/alpine3.5/no-pic.patch \
    && wget -q https://raw.githubusercontent.com/docker-library/golang/master/1.7/alpine3.5/17847.patch \
    && cd /usr/local/go/src \
    && patch -p2 -i /go/src/no-pic.patch \
    && patch -p2 -i /go/src/17847.patch \
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
