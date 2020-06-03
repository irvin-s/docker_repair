# golangci-lint
# docker run --rm -v $(pwd):/go/src/github.com/your-name/project -w /go/src/github.com/your-name/project supinf/golangci-lint:1.12 run --config .golangci.yml

FROM alpine:3.8

ENV GOLANGCI_LINT_VERSION=1.12.3 \
    PATH=/go/bin:/usr/local/go/bin:$PATH \
    GOPATH=/go

RUN apk --no-cache add gcc musl-dev
RUN apk --no-cache add --virtual build-deps bash openssl go git \
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
    && : Install golangci-lint \
    && cd / \
    && GOLANGCI_LINT_URL="https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz" \
    && GOLANGCI_LINT_SHA256="c531688661b500d4c0c500fcf57f829388a4a9ba79697c2e134302aedef0cd46" \
    && wget -q "${GOLANGCI_LINT_URL}" -O golangci-lint.tar.gz \
    && echo "${GOLANGCI_LINT_SHA256}  golangci-lint.tar.gz" | sha256sum -c - \
    && tar -xzf golangci-lint.tar.gz \
    && mkdir -p /go/bin \
    && mv "/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint" /go/bin/ \
    && : \
    && : Clean up \
    && apk del --purge -r build-deps \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && find / -depth -type f -name "*_test.go" -exec rm -f {} \; \
    && find / -depth -type f -name README.md -exec rm -f {} \; \
    && find /usr/local/go -depth -type d -name go-build -exec rm -rf {} \; \
    && rm -rf /root/.cache /usr/local/go/pkg/bootstrap /go/src/github.com \
              /var/cache/* /var/lib/apk* /golang.tar.gz /golangci*

WORKDIR /go/src

ENTRYPOINT ["golangci-lint"]
CMD ["--help"]
