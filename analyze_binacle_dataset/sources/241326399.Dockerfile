# golangci-lint
# docker run --rm -v $(pwd):/go/src/github.com/your-name/project -w /go/src/github.com/your-name/project supinf/golangci-lint:1.16 run --config .golangci.yml

FROM alpine:3.9 AS build
RUN apk --no-cache add wget
ENV GOLANGCI_LINT_VERSION=1.16.0 \
    GOLANGCI_LINT_REPO=github.com/golangci/golangci-lint
ENV GOLANGCI_LINT_URL="https://${GOLANGCI_LINT_REPO}/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz" \
    GOLANGCI_LINT_SHA256="5343fc3ffcbb9910925f4047ec3c9f2e9623dd56a72a17ac76fb2886abc0976b"
RUN wget -q "${GOLANGCI_LINT_URL}" -O golangci-lint.tar.gz
RUN echo "${GOLANGCI_LINT_SHA256}  golangci-lint.tar.gz" | sha256sum -c -
RUN tar -xzf golangci-lint.tar.gz
RUN mv "golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint" /
RUN chmod +x /golangci-lint

FROM golang:1.12.5-alpine3.9
RUN apk --no-cache add gcc musl-dev
COPY --from=build /golangci-lint /usr/bin/
ENTRYPOINT ["golangci-lint"]
CMD ["--help"]
