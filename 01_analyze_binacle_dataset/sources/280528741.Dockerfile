FROM golang:1.9 AS builder

# Installing godep
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.3.1/dep-linux-amd64 && chmod +x /usr/local/bin/dep

RUN mkdir -p /go/src/github.com/petronetto/echo-mongo-api
WORKDIR /go/src/github.com/petronetto/echo-mongo-api

# copies the Gopkg.toml and Gopkg.lock to WORKDIR
COPY ./ ./

# install the dependencies without checking for go code
RUN dep ensure -vendor-only

# Build my app
RUN go build -o /app/server .
CMD ["/app/server"]