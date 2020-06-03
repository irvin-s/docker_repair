FROM golang:1.10 AS builder

# Since vendor/ is checked in, don't need all this to build
# RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 && chmod +x /usr/local/bin/dep

RUN mkdir -p /go/src/github.com/emojitracker/emojitrack-gostreamer
WORKDIR /go/src/github.com/emojitracker/emojitrack-gostreamer

# COPY Gopkg.toml Gopkg.lock ./
# RUN dep ensure -vendor-only

COPY vendor/ ./vendor/
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
	go build -ldflags "-s" -a -installsuffix cgo -o emojitrack-gostreamer

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/emojitracker/emojitrack-gostreamer/emojitrack-gostreamer .
ENTRYPOINT ["./emojitrack-gostreamer"]
