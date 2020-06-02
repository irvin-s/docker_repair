# gometalinter
#
# docker run --rm -v $(pwd):/go/src/github.com/your-name/project -w /go/src/github.com/your-name/project supinf/gometalinter:2.0
# docker run --rm -v $(pwd):/go/src/github.com/your-name/project -w /go/src/github.com/your-name/project supinf/gometalinter:2.0 --vendor --deadline 60s --disable-all --enable=megacheck --aggregate ./...

FROM alpine:3.8

ENV METALINTER_VERSION=v2.0.11 \
    PATH=/go/bin:/usr/local/go/bin:$PATH \
    PAGER=less \
    GOPATH=/go

RUN apk --no-cache add less
RUN apk --no-cache add --virtual build-deps bash gcc musl-dev openssl go git \
    && : \
    && : Install go 1.11 \
    && GOLANG_VERSION=1.11.4 \
    && GOLANG_SRC_URL="https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz" \
    && GOLANG_SRC_SHA256="4cfd42720a6b1e79a8024895fa6607b69972e8e32446df76d6ce79801bbadb15" \
    && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
    && wget -q "${GOLANG_SRC_URL}" -O golang.tar.gz \
    && echo "${GOLANG_SRC_SHA256}  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && cd /usr/local/go/src \
    && ./make.bash \
    && mkdir -p /go/src \
    && chmod -R 777 /go \
    && : \
    && : Install gometalinter \
    && go get -u github.com/alecthomas/gometalinter \
    && cd /go/src/github.com/alecthomas/gometalinter \
    && git checkout ${METALINTER_VERSION} \
    && go install github.com/alecthomas/gometalinter \
    && gometalinter --install \
    && : \
    && : Clean up \
    && apk del --purge -r build-deps \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && find / -depth -type f -name "*_test.go" -exec rm -f {} \; \
    && find / -depth -type f -name README.md -exec rm -f {} \; \
    && find /usr/local/go -depth -type d -name go-build -exec rm -rf {} \; \
    && rm -rf /root/.cache /usr/local/go/pkg/bootstrap /go/src/github.com \
              /var/cache/* /var/lib/apk* /golang.tar.gz

WORKDIR /go/src

ENTRYPOINT ["gometalinter"]
CMD ["--help"]
