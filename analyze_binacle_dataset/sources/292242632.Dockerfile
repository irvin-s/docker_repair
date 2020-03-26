# Build stage
ARG GO_VERSION=1.10
ARG PROJECT_PATH=/go/src/github.com/dustin-decker/deflek
FROM golang:${GO_VERSION}-alpine AS builder
RUN apk --update add ca-certificates
RUN apk add --no-cache git
ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep
RUN adduser -D -u 59999 container-user
WORKDIR /go/src/github.com/dustin-decker/deflek
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY ./ ${PROJECT_PATH}
RUN export PATH=$PATH:`go env GOHOSTOS`-`go env GOHOSTARCH` \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build --ldflags '-extldflags "-static"' -o deflek \
    && go test $(go list ./... | grep -v /vendor/)

# Production image
FROM scratch
EXPOSE 8080
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /go/src/github.com/dustin-decker/deflek/deflek /deflek
COPY --from=builder /go/src/github.com/dustin-decker/deflek/config.example.yaml /config.example.yaml
COPY --from=builder /go/src/github.com/dustin-decker/deflek/config.yaml /config.yaml
USER container-user
ENTRYPOINT ["/deflek"]]