FROM golang:1.11.0 AS builder

# Download and install the latest release of dep
ADD https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

WORKDIR $GOPATH/src/github.com/lsowen/maybemaybemaybe_bot
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN CGO_ENABLED=1 GOOS=linux go build -ldflags "-linkmode external -extldflags -static" -o /maybemaybemaybe_bot .

FROM alpine:3.8
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /maybemaybemaybe_bot ./
ENTRYPOINT ["./maybemaybemaybe_bot"]